
import 'package:musicapp/models/page.dart';
import 'package:musicapp/models/questionformat.dart';

class Module {
   Module({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.locked,
    required this.modulenumber,
    required this.requirement,
    required this.requirementPage,
    required this.isCoursedone,
    required this.stars,
    required this.questions,
    required this.pages,
  });
  final String title;
  int stars;
  bool isCoursedone;
  final List<String> requirement;
  List<List<PageInfo>>? requirementPage;
  final String subtitle;
  final int modulenumber;
  bool locked;
  final String image;
  final List<QuizQuestion> questions;
  final List<PageInfo> pages;

  // ignore: non_constant_identifier_names
  factory Module.fromFirestore(Map<String, dynamic> data, List<QuizQuestion> questions, List<List<PageInfo>>? requirementPage,  List<PageInfo> pages  ) {
    return Module(
      image: data['image'],
      title: data['title'],
      subtitle: data['subtitle'],
      locked: data['locked'],
      modulenumber: data['modulenumber'],
      requirement: List<String>.from(data['requirement']),
      requirementPage: requirementPage,
      isCoursedone: data['isCoursedone'],
      stars: data['stars'],
      questions: questions,
      pages: pages
    );
  }
}
