
import 'package:musicapp/models/final_result_text.dart';
import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/Advanced_page/advanced_newlevel_screen.dart';
import 'package:musicapp/screens/mqc_result/mcq_result_review.dart';
import 'package:musicapp/screens/selectmodule_screen1.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Resultmcq extends StatelessWidget {
  const Resultmcq(
      {super.key,
      required this.resultList,
      required this.score,
      required this.coursenumber});
  final List<WrongAnswer> resultList;
  final int questionLength = 5;
  final int coursenumber;
  final String resulttext = '';
  final int score;

  @override
  Widget build(BuildContext context) {
    bool buttonswitch = score < 5;
    return Consumer<ModuleProvider>(
      builder: (context, value, child) {
        bool iscoursedone = false;
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 236, 215, 140),
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Score:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        fontFamily: "RobotoSlab"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/images/staff.jpg'),
                      ),
                      Positioned(
                        top: 26,
                        right: 77,
                        child: Text('$score',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 70,
                                fontWeight: FontWeight.w900,
                                fontFamily: "FrankRuhlLibre")),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 76,
                        child: Text('$questionLength',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 70,
                                fontFamily: "FrankRuhlLibre")),
                      ),
                    ],
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    _feedbacktext(score),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      var moduleProvider = context.read<ModuleProvider>();
                      iscoursedone = value.allModulesCompleted();
                      !iscoursedone
                          ? moduleProvider.updatelock(coursenumber + 1)
                          : null;
                      moduleProvider.updateStars(coursenumber, score);
                      moduleProvider.updateCourse(coursenumber).then((e) {
                        if (buttonswitch) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => McqReview(
                                  resultList: resultList,
                                  iscoursedone: iscoursedone),
                            ),
                          );
                        } else if (iscoursedone) {
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
                      });
                    },
                    child: Text(
                      buttonswitch
                          ? 'See where you went wrong!'
                          : 'Back to the modules',
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _feedbacktext(int yourscore) {
    return compliments[yourscore]!;
  }
}
