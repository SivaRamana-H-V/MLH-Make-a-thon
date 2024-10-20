import 'package:flutter/material.dart';
import 'dart:typed_data';

class MyBarriers extends StatelessWidget {
  final double barriersWidth;
  final double barriersHeight;

  const MyBarriers({
    super.key,
    required this.barriersWidth,
    required this.barriersHeight,
  });

  // Replace the random generator with static data
  Uint8List _getStaticData() {
    // Define a static dataset
    return Uint8List.fromList([
      32, // Sa
      48, // Re
      64, // Ga
      80, // Ma
      96, // Pa
      112, // Dha
      128, // Ni
      144, // Sa (High)
    ]);
    // Static data array
  }

  @override
  Widget build(BuildContext context) {
    Uint8List staticData = _getStaticData(); // Use static data

    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 3 / 4 * barriersHeight,
      ),
      painter: AudioVisualizerPainter(staticData),
    );
  }
}

class AudioVisualizerPainter extends CustomPainter {
  final Uint8List audioData;

  AudioVisualizerPainter(this.audioData);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 2.0;

    double width = size.width;
    double height = size.height;
    int dataLength = audioData.length;
    double step = height / dataLength; // Step for height instead of width

    for (int i = 0; i < dataLength; i++) {
      double y = i * step;
      double x = (audioData[i] / 255.0) * width; // X varies with audio data

      // Draw the lines starting from the right edge towards the left
      canvas.drawLine(
          Offset(width, y), Offset(width - x, y), paint); // Align to right side
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
