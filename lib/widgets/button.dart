import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(45)),
          color: bgColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: textColor),
        ),
      ),
    );
  }
}
