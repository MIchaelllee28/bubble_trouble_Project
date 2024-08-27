import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  const MyBall({super.key, required this.x, required this.y});

  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: Colors.deepPurple,
          height: 10,
          width: 10,
        ),
      ),
    );
  }
}
