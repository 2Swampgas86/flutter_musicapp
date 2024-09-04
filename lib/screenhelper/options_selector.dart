import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options(
      {super.key,
      required this.selected,
      required this.item,
      required this.answer});
  final String selected;
  final String item;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      decoration: BoxDecoration(
        color: selected == item
            ? selected == answer
                ? const Color.fromARGB(255, 7, 135, 94)
                : const Color.fromARGB(255, 187, 24, 24)
            : const Color.fromARGB(73, 255, 255, 255),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          item,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
