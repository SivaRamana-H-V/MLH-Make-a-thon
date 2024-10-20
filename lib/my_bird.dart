import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({
    super.key,
    required this.birdY,
    required this.birdWidth,
    required this.birdHeight,
  });

  final double birdY;
  final double birdWidth;
  final double birdHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * birdWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
        child: Image.asset('assets/ball.png'),
      ),
    );
  }
}
