import 'package:musicapp/models/page.dart';
import 'package:musicapp/models/questionformat.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.coursenumber,
  });

  final int coursenumber;

  @override
  Widget build(BuildContext context) => Consumer<ModuleProvider>(
        builder: (context, value, child) {
          final String imageURL = value.moduleList[coursenumber].image;
          final String title = value.moduleList[coursenumber].title;
          final bool isCoursedone = value.moduleList[coursenumber].isCoursedone;
          final String subtitle = value.moduleList[coursenumber].subtitle;
          final List<String> requirement =
              value.moduleList[coursenumber].requirement;
          List<List<PageInfo>>? requirementPage =
              value.moduleList[coursenumber].requirementPage;
          final int stars = value.moduleList[coursenumber].stars;
          final List<QuizQuestion> questions =
              value.moduleList[coursenumber].questions;
          final List<PageInfo> moduleInfo =
              value.moduleList[coursenumber].pages;

          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey[900],
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageURL),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.radio_button_off_outlined,
                          color: Colors.black,
                          size: 10,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                buildStarIcons(stars),
                CupertinoButton(
                  onPressed: requirementPage != null
                      ? () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: ((context) => CupertinoActionSheet(
                                  title: const Text('Requirements'),
                                  message: const Text(
                                      'Click on the courses below for a quick recap!'),
                                  actions: List.generate(
                                    requirement.length,
                                    (index) => CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfoScreen(
                                                  moduleInfo:
                                                      requirementPage[index],
                                                  courseNumber: coursenumber,
                                                  questions: questions)),
                                        );
                                      },
                                      child: Text(
                                        requirement[index],
                                      ),
                                    ),
                                  ),
                                )),
                          );
                        }
                      : null,
                  child: requirementPage != null
                      ? const Text('Check Requirements')
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: buildCourseButton(context, isCoursedone, moduleInfo,
                      coursenumber, questions),
                )
              ],
            ),
          );
        },
      );
  Widget buildStarIcons(int stars) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
        (index) => Icon(
          index < stars ? Icons.star_rate_rounded : Icons.star_border_rounded,
          size: 50,
        ),
      ),
    );
  }

  // Method to build the course button
  Widget buildCourseButton(
      BuildContext context,
      bool isCoursedone,
      List<PageInfo> moduleInfo,
      int coursenumber,
      List<QuizQuestion> questions) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InfoScreen(
                  moduleInfo: moduleInfo,
                  courseNumber: coursenumber,
                  questions: questions)),
        );
      },
      child: Text(isCoursedone ? 'Retake Course' : 'Start Course'),
    );
  }
}
