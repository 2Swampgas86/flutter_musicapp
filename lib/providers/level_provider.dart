import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, int> levelModulesCount = {};

  Future<void> loadLevelModulesCount() async {
    try {
      // Fetch document that stores the number of courses in each level
      DocumentSnapshot levelInfoSnapshot = await _firestore.collection('level_info').doc('level_counts').get();
      
      if (levelInfoSnapshot.exists) {
        Map<String, dynamic> data = levelInfoSnapshot.data() as Map<String, dynamic>;

        // Assuming 'level_modules' field is a map storing the number of modules per level
        levelModulesCount = Map<String, int>.from(data['level_modules']);
      }
      notifyListeners();
    } catch (e) {
      print('Error loading level modules count: $e');
    }
  }

  int getModuleCount(String levelName) {
    return levelModulesCount[levelName] ?? 0;
  }
}
