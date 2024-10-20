import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final barriersWidth;
  final barriersHeight;

  const MyBarriers({
    super.key,
    this.barriersWidth,
    this.barriersHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * barriersWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * barriersHeight / 2,
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            width: 10,
            color: Colors.green[800]!,
          ),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
