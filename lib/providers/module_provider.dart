import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/models/levels_enum.dart';
import 'package:musicapp/models/module.dart';
import 'package:musicapp/models/page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musicapp/models/questionformat.dart';
// Define a provider class to manage the state of the module list

class ModuleProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Module> moduleList = []; // Private variable to hold the modules
  List<Module> get modules => moduleList; // Getter to access modules
  String get id => userId;
  Level currentLevel = Level.beginner;
  void clearModuleList() {
    moduleList.clear();
    notifyListeners();
  }

  Future<void> addmodulestoUser(Level level) async {
    currentLevel = level;

    try {
      // Fetch all module documents
      QuerySnapshot modulesSnapshot =
          await _firestore.collection(currentLevel.collectionname).get();
      if (modulesSnapshot.docs.isEmpty) {
        return;
      }

      // Iterate through each module document
      for (var moduleDoc in modulesSnapshot.docs) {
        // Prepare the new subcollection path under the user document
        DocumentReference newModuleDocRef = _firestore
            .collection('users')
            .doc(userId)
            .collection(currentLevel.collectionname)
            .doc(moduleDoc.id);

        // Fetch subcollections
        List<QuizQuestion> questions =
            await _fetchQuizQuestions(moduleDoc.reference);
        List<List<PageInfo>>? requirementPages =
            await _fetchRequirementPages(moduleDoc.reference);
        List<PageInfo> pages = await _fetchPages(moduleDoc.reference);

        // Create the Module object and add it to the module list

        Module module = Module.fromFirestore(
          moduleDoc.data() as Map<String, dynamic>,
          questions,
          requirementPages,
          pages,
        );

        moduleList.add(module);

        // Use a batch to perform atomic writes
        WriteBatch batch = _firestore.batch();

        // Copy the main module document
        batch.set(newModuleDocRef, moduleDoc.data());

        // Copy the subcollections
        await _copySubcollection(
            moduleDoc.reference, newModuleDocRef, 'questions', batch);
        await _copySubcollection(
            moduleDoc.reference, newModuleDocRef, 'requirementPage', batch);
        await _copySubcollection(
            moduleDoc.reference, newModuleDocRef, 'module_info', batch);

        // Commit the batch
        await batch.commit();
      }
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }
    try {
      Map<String, dynamic> updates = {
        'levels.${level.name}.locked': false,
        'levels.${level.name}.open': true,
      };

      if (level.name == 'expert') {
        updates['levels.intermediate.locked'] = false;
      }

      // Perform the update
      await _firestore.collection('users').doc(userId).update(updates);
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }
    notifyListeners();
  }

  Future<void> loadModulesFromUser(Level level) async {
    currentLevel = level;

    try {
      // Fetch all module documents from the user's collection
      QuerySnapshot modulesSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection(currentLevel.collectionname)
          .get();

      if (modulesSnapshot.docs.isEmpty) {
        return;
      }

      // Clear the current moduleList
      moduleList.clear();

      // Iterate through each module document
      for (var moduleDoc in modulesSnapshot.docs) {
        // Fetch subcollections
        List<QuizQuestion> questions =
            await _fetchQuizQuestions(moduleDoc.reference);
        List<List<PageInfo>>? requirementPages =
            await _fetchRequirementPages(moduleDoc.reference);
        List<PageInfo> pages = await _fetchPages(moduleDoc.reference);

        // Create the Module object and add it to the module list
        Module module = Module.fromFirestore(
          moduleDoc.data() as Map<String, dynamic>,
          questions,
          requirementPages,
          pages,
        );

        moduleList.add(module);
      }
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }

    notifyListeners();
  }

  // Method to update the star value for a specific module
  Future<void> updateStars(int moduleNumber, int stars) async {
    modules[moduleNumber].stars = stars;
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(currentLevel.collectionname)
          .doc('module_${moduleNumber + 1}')
          .update(
        {
          'stars': stars,
        },
      );
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> updatelock(int moduleNumber) async {
    modules[moduleNumber].locked = false;
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(currentLevel.collectionname)
          .doc('module_${moduleNumber + 1}')
          .update(
        {
          'locked': false,
        },
      );
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> updateCourse(int moduleNumber) async {
    modules[moduleNumber].isCoursedone = true;
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection(currentLevel.collectionname)
          .doc('module_${moduleNumber + 1}')
          .update(
        {
          'isCoursedone': true,
        },
      );
      await _firestore.collection('users').doc(userId).update(
        {
          'levels.${currentLevel.name}.module_done': moduleNumber + 1,
        },
      );
    } catch (e) {
      const Center(child: Text('An error occurred'));
    }
    notifyListeners(); // Notify listeners to rebuild UI
  }

  bool allModulesCompleted() {
    return modules.every((module) => module.isCoursedone);
  }

  void unlockNextLevel() {
    if (currentLevel == Level.beginner && allModulesCompleted()) {
      addmodulestoUser(Level.intermediate);
    } else if (currentLevel == Level.intermediate && allModulesCompleted()) {
      addmodulestoUser(Level.expert);
    }
    notifyListeners();
  }

  Future<void> _copySubcollection(
    DocumentReference sourceDocRef,
    DocumentReference targetDocRef,
    String subcollectionName,
    WriteBatch batch,
  ) async {
    try {
      QuerySnapshot subcollectionSnapshot =
          await sourceDocRef.collection(subcollectionName).get();
      if (subcollectionSnapshot.docs.isEmpty) {
        return;
      }
      for (var subDoc in subcollectionSnapshot.docs) {
        DocumentReference newSubDocRef =
            targetDocRef.collection(subcollectionName).doc(subDoc.id);
        batch.set(newSubDocRef, subDoc.data());
      }
    } catch (e) {
      const Center(child: Text('An error occurred'));
      ;
    }
  }

  Future<List<QuizQuestion>> _fetchQuizQuestions(
      DocumentReference moduleDocRef) async {
    QuerySnapshot questionSnapshot =
        await moduleDocRef.collection('questions').get();

    return questionSnapshot.docs.map(
      (doc) {
        var data = doc.data() as Map<String, dynamic>;
        return QuizQuestion.fromFirestore(data);
      },
    ).toList();
  }

  Future<List<List<PageInfo>>?> _fetchRequirementPages(
      DocumentReference moduleDocRef) async {
    List<List<PageInfo>>? requirementPages = [];
    QuerySnapshot requiredPageSnapshot =
        await moduleDocRef.collection('requirementPage').get();
    if (requiredPageSnapshot.docs.isEmpty) {
      requirementPages = null;

      return requirementPages;
    }

    for (var doc in requiredPageSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<PageInfo> pages = (data[doc.id] as List)
          .map((pageData) => PageInfo.fromFirestore(pageData))
          .toList();
      requirementPages.add(pages);
    }

    return requirementPages;
  }

  Future<List<PageInfo>> _fetchPages(DocumentReference moduleDocRef) async {
    QuerySnapshot pageSnapshot =
        await moduleDocRef.collection('module_info').get();
    if (pageSnapshot.docs.isEmpty) {
      const Center(child: Text('An error occurred'));
    }

    return pageSnapshot.docs.map(
      (doc) {
        var data = doc.data() as Map<String, dynamic>;
        return PageInfo.fromFirestore(data);
      },
    ).toList();
  }
}
