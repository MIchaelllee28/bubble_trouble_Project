import 'package:flutter/material.dart';

class MyMissile extends StatelessWidget {
  const MyMissile(
      {super.key, required this.height, required this.x, required this.y});

  final double x;
  final double y;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        height: height,
        width: 2,
        color: Colors.red,
      ),
    );
  }
}
