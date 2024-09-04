import 'package:musicapp/models/levels_enum.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/opening_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancedOpening extends StatelessWidget {
  const AdvancedOpening({super.key});

  @override
  Widget build(BuildContext context) {
   return  Consumer<ModuleProvider>(
      builder: (context, value, child) => 
     OpeningPage(
      stringList: ['Congratulations!', getCompletionMessage(value.currentLevel)],
    ));
  }
}

String getCompletionMessage(Level level) {
    switch (level) {
      case Level.beginner:
        return "Keep up the great work as you move on to the Intermediate level.";
      case Level.intermediate:
        return "Fantastic job on finishing the Intermediate level! Your understanding of music theory is deepening, and your skills are growing stronger. Get ready to tackle the Advanced level and explore the intricate details of music theory. Keep pushing forward!";
      case Level.expert:
        return "Amazing accomplishment on completing the Expert level! You've mastered some of the most challenging aspects of music theory. Your dedication and hard work are truly inspiring. You're now ready to apply your knowledge and creativity in music. Bravo!";
      default:
        return "";
    }
  }
