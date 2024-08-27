import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.myIcon,
    required this.tap,
  });

  final IconData myIcon;
  final void Function() tap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: tap, child: Icon(myIcon));
  }
}
