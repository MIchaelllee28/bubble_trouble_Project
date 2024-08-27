import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({super.key, required this.positions});

  final double positions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(positions, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 199, 70, 184),
          ),
        ),
      ),
    );
  }
}
