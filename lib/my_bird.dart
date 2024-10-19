import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({
    super.key,
    required this.birdY,
  });

  final double birdY;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.asset('assets/ball.png'),
      ),
    );
  }
}
