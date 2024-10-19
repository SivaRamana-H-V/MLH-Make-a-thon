import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:buffered_list_stream/buffered_list_stream.dart';
import 'dart:typed_data';

import 'package:record/record.dart';

class PitchCubit extends Cubit<double> {
  final AudioRecorder _audioRecorder;
  final PitchDetector _pitchDetectorDart;
  double _lastValue = 0.0; // Store the last emitted value

  PitchCubit(
    this._audioRecorder,
    this._pitchDetectorDart,
  ) : super(0.0) {
    _init();
  }

  _init() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      final recordStream = await _audioRecorder.startStream(const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        numChannels: 1,
        bitRate: 128000,
        sampleRate: PitchDetector.DEFAULT_SAMPLE_RATE,
      ));

      var audioSampleBufferedStream = bufferedListStream(
        recordStream.map((event) {
          return event.toList();
        }),
        // The library converts a PCM16 to 8bits internally. So we need twice as many bytes
        PitchDetector.DEFAULT_BUFFER_SIZE * 2,
      );

      await for (var audioSample in audioSampleBufferedStream) {
        final intBuffer = Uint8List.fromList(audioSample);

        _pitchDetectorDart
            .getPitchFromIntBuffer(intBuffer)
            .then((detectedPitch) {
          if (detectedPitch.pitched) {
            double numericValue = _mapPitchToValue(detectedPitch.pitch);
            // Emit new state only if value changes smoothly
            if ((_lastValue - numericValue).abs() >= 0.0001) {
              // Smallest change for smoother transitions
              _lastValue = numericValue;
              emit(numericValue); // Emit only the numeric value
            }
          }
        });
      }
    } else {
      emit(0.0); // Emit 0.0 if microphone permission is denied
    }
  }

  double _mapPitchToValue(double frequency) {
    // Define the pitch mapping range for human vocals
    const double minFrequency = 85.0; // Minimum frequency for low male voices
    const double maxFrequency =
        255.0; // Maximum frequency for high female voices

    // Handle out-of-range values
    if (frequency < minFrequency)
      return 1.0; // Return 1.0 when frequency is too low
    if (frequency > maxFrequency)
      return -1.0; // Return -1.0 when frequency is too high

    // Normalize the frequency within the range
    double normalizedValue =
        (frequency - minFrequency) / (maxFrequency - minFrequency);

    // Scale it to -1.0 to 1.0 with smoothness
    double smoothValue = 2 * (normalizedValue) - 1;

    // Apply smoothing to avoid abrupt changes (exponential smoothing factor)
    smoothValue = _applySmoothing(smoothValue);

    return smoothValue;
  }

  double _applySmoothing(double value) {
    // Adjust the smoothness factor (lower value means smoother changes)
    const double smoothingFactor = 0.8;

    // Return smoothed value by interpolating between the last value and the current one
    return smoothingFactor * _lastValue + (1 - smoothingFactor) * value;
  }
}
