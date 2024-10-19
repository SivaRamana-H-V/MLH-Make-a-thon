import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voice_control_race_game/barriers.dart';
import 'package:voice_control_race_game/my_bird.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdY;
  bool gameHasStarted = true;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  int highScore = 0;

  // Variables to define barrier and bird dimensions
  final double birdWidth = 0.1; // Adjust based on the bird's size
  final double birdHeight = 0.1; // Adjust based on the bird's size
  final double barrierWidth = 0.2; // Adjust based on the barriers' width

  // Height of the barriers for collision detection
  final double barrierHeightOneTop = 200.0;
  final double barrierHeightOneBottom = 200.0;
  final double barrierHeightTwoTop = 250.0;
  final double barrierHeightTwoBottom = 150.0;

  @override
  void initState() {
    super.initState();
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdY = initialHeight - height;
      });

      // Move barriers
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
          score++; // Increment score as the bird passes the first barrier
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          score++; // Increment score as the bird passes the second barrier
        } else {
          barrierXtwo -= 0.05;
        }
      });

      // Check for collisions
      if (birdY > 1) {
        birdY = 1;
        timer.cancel();
        // gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   if (gameHasStarted) {
      //     jump();
      //   } else {
      //     startGame();
      //   }
      // },
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
                      const Text(
                        // pitchCubitState.toString(),
                        '',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: gameHasStarted
                            ? const Text(' ')
                            : const Text(
                                'T A P   T O   P L A Y',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                      ),
                      MyBird(birdY: birdY),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 0),
                          alignment: Alignment(barrierXone, 1.1),
                          child: const MyBarriers(size: 200.0)),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 0),
                          alignment: Alignment(barrierXone, -1.1),
                          child: const MyBarriers(size: 200.0)),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 0),
                          alignment: Alignment(barrierXtwo, 1.1),
                          child: const MyBarriers(size: 150.0)),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 0),
                          alignment: Alignment(barrierXtwo, -1.1),
                          child: const MyBarriers(size: 250.0)),
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
                      Text('Best: ${highScore.toString()}',
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
  }
}
