import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key, required this.stringList});

  final List<String> stringList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 100,
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Color.fromARGB(255, 243, 201, 63),
              fontSize: 25,
            
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: false,
              animatedTexts: stringList
                  .map(
                    (sentence) => FadeAnimatedText(
                      sentence,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
