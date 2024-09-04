
import 'package:musicapp/screens/opening_screen.dart';
import 'package:flutter/material.dart';

class McqResultOpening extends StatelessWidget {
  const McqResultOpening({super.key});

  @override
  Widget build(BuildContext context) {
    return const OpeningPage(
      stringList: ['Quiz Completed!', "Let's see your results!"],
    );
  }
}
