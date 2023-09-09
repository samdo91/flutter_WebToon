import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final String name;

  const Button2({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber.shade600,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
        child: Text(
          name,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
