import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicapp/models/levels_enum.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/selectmodule_screen1.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ModuleTile extends StatelessWidget {
  const ModuleTile({super.key, required this.level});

  final Level level;
  Future<Map<String, dynamic>> getDetails(String userId) async {
    final userDetail =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // Fetch the specific level data
    final levelData = userDetail.data()?['levels']?[level.name];

    if (levelData != null) {
      return {
        'locked': levelData['locked'],
        'open': levelData['open'],
        'number': levelData['module_length'],
        'done': levelData['module_done'],
      };
    } else {
      // Return default values if the level data is not found
      return {
        'locked': true,
        'open': false,
        'number': 0,
        'done': 0,
      };
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<ModuleProvider>(
        builder: (context, value, child) {
          return FutureBuilder<Map<String, dynamic>>(
              future: getDetails(value.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(25),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: const CircleAvatar(radius: 40)),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                } else {
                  final bool locked = snapshot.data!['locked'];

                  final int totalModules = snapshot.data!['number'];
                  final int completedModules = snapshot.data!['done'];
                  final bool open = snapshot.data!['open'];

                  final double percentageCompleted =
                      (completedModules / totalModules) * 100;
                  final String percentageCompletedText =
                      percentageCompleted.round().toString();

                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 100,
                          radius: 40,
                          lineWidth: 5,
                          percent: percentageCompleted / 100,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text('$percentageCompletedText%'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          level.name.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              fontFamily: "FrankRuhlLibre"),
                        ),
                        ElevatedButton(
                          onPressed: locked
                              ? null
                              : open
                                  ? () {
                                      context
                                          .read<ModuleProvider>()
                                          .loadModulesFromUser(level)
                                          .then((e) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectModule(
                                                          moduleList:
                                                              value.moduleList),
                                                ),
                                              ));
                                    }
                                  : () {
                                      context
                                          .read<ModuleProvider>()
                                          .addmodulestoUser(level)
                                          .then((e) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectModule(
                                                          moduleList:
                                                              value.moduleList),
                                                ),
                                              ));
                                    },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10),
                            ),
                            backgroundColor: !locked
                                ? MaterialStateProperty.all(
                                    const Color.fromARGB(255, 49, 189, 236),
                                  )
                                : MaterialStateProperty.all(Colors.grey),
                            elevation: MaterialStateProperty.all(10),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 20),
                            ),
                            shape: MaterialStateProperty.all(
                              const StadiumBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          child: !locked
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Get Started'),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                )
                              : const Icon(Icons.lock),
                        ),
                      ],
                    ),
                  );
                }
              });
        },
      );
}
