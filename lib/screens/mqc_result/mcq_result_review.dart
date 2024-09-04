
import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/screens/Advanced_page/advanced_newlevel_screen.dart';
import 'package:musicapp/screens/selectmodule_screen1.dart';
import 'package:provider/provider.dart';

class McqReview extends StatelessWidget {
  const McqReview({
    super.key,
    required this.resultList,
    required this.iscoursedone
  });

  final List<WrongAnswer> resultList;
  final bool iscoursedone;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModuleProvider>(
      builder: (context, value, child) => Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: resultList.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Text(
                        'See where you went wrong!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          fontFamily: "FrankRuhlLibre",
                        ),
                      );
                    } else if (index == resultList.length + 1) {
                      return const SizedBox(
                          height: 70); // Extra space for the button
                    } else {
                      return WrongAnswerWidget(question: resultList[index - 1]);
                    }
                  },
                ),
                Positioned(
                  bottom: 15.0,
                  left: 25,
                  right: 25,
                  child: ElevatedButton(
                    onPressed: () {
                       var moduleProvider = context.read<ModuleProvider>();
                      if (iscoursedone) {
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const AdvancedPage(),
                                  ),
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectModule(
                                      moduleList: moduleProvider.modules,
                                    ),
                                  ),
                                  (route) => false,
                                );
                              }
                    },
                    child: const Text('Back to the modules'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WrongAnswerWidget extends StatelessWidget {
  final WrongAnswer question;

  const WrongAnswerWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Your Answer: ${question.yourAnswer}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Correct Answer: ${question.correctAnswer}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
