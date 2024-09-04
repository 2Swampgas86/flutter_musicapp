import 'package:flutter/material.dart';

class ResultOpeningScreen extends StatelessWidget {
  const ResultOpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("Quiz Completed!"),),
    );
  }
}