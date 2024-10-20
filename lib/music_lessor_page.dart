// ignore_for_file: dead_code

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:record/record.dart';
import 'package:voice_control_race_game/my_bird.dart';
import 'package:voice_control_race_game/pitch_detecter.dart';

class MusicLessorPage extends StatefulWidget {
  const MusicLessorPage({super.key});

  @override
  State<MusicLessorPage> createState() => _MusicLessorPageState();
}

class _MusicLessorPageState extends State<MusicLessorPage> {
  static double birdY = 1.0;
  bool gameHasStarted = true;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  final birdWidth = 0.1;
  final birdHeight = 0.1;
  static List<double> barriersX = [2, 2 + 1.5];
  static double barriersWidth = 0.2;
  static List<List<double>> barriersHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  final double gravity = 0.1; // Gravity to pull the bird down

  @override
  void initState() {
    super.initState();
    startBarriersMovement();
  }

  void startBarriersMovement() {
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (birdY == 1) {
        // If bird is on the ground, stop moving barriers
        return;
      }

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
          score++;
        } else {
          barrierXone -= 0.05;
        }

        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          score++;
        } else {
          barrierXtwo -= 0.05;
        }
      });
    });
  }

  bool birdDead() {
    if (birdY > 1 || birdY < -1) {
      return true;
    }
    for (int i = 0; i < barriersX.length; i++) {
      if (barriersX[i] <= birdWidth &&
          barriersX[i] + barriersWidth >= -birdWidth &&
          (birdY <= -1 + barriersHeight[i][0] ||
              birdY + birdHeight >= 1 - barriersHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PitchCubit(AudioRecorder(), PitchDetector()),
      child: BlocBuilder<PitchCubit, double>(builder: (context, pitchValue) {
        // Use the pitch value directly to update the bird's position
        if (gameHasStarted) {
          if (pitchValue != 0.0) {
            birdY = pitchValue; // Use pitch to make the bird jump
          } else {
            birdY -=
                pitchValue - 1; // Bird falls down when no pitch is detected
          }

          // Check for collision

          if (birdY > 1 || birdY < -1) {
            // If bird goes out of bounds, reset the game
            birdY = -1;
          }
        }

        return GestureDetector(
          onTap: () {
            if (!gameHasStarted) {
              setState(() {
                gameHasStarted = true;
              });
            }
          },
          child: SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.blue,
                      child: Stack(
                        children: [
                          Text('birdY Value: $birdY \nPitch Value: $pitchValue',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                          Container(
                            alignment: const Alignment(0, -0.3),
                            child: gameHasStarted
                                ? const Text('')
                                : const Text(
                                    'T A P   T O   S T A R T',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                          ),
                          // Bird widget
                          MyBird(
                              birdY: birdY,
                              birdWidth: birdWidth,
                              birdHeight: birdHeight),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.brown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Score: ${score.toString()}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
