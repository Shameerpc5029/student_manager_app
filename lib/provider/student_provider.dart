import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager/db/functions/db_functions.dart';
import 'package:student_manager/db/model/student_model.dart';
import 'package:student_manager/screens/home_screen.dart';

const kImage = "assets/images/student (2).png";

class StudentProvider extends ChangeNotifier {
  List<StudentModel> dataFound = [];
  File? image;
  bool imageVisible = false;
  List<StudentModel> filterSearch = StudentDb.studentList;

  splsh(BuildContext context) async {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      ),
    );
    notifyListeners();
  }

  Future<void> getAllData(context) async {
    final students = await StudentDb.getAllStudents();
    dataFound = students;
    notifyListeners();
  }

  void addStudent(data) {
    dataFound.clear();
    dataFound.addAll(data);
    notifyListeners();
  }

  void search(String keyboard) {
    List<StudentModel> results = [];
    if (keyboard.isEmpty) {
      results = filterSearch;
    } else {
      results = filterSearch
          .where(
            (element) => element.name.contains(
              keyboard,
            ),
          )
          .toList();
    }

    dataFound = results;
    notifyListeners();
  }

  Future<void> deleteData(String id, context) async {
    if (id.isEmpty) {
      log('No id');
    } else {
      await StudentDb().deleteStutent(context, id);
      log('deleted successfully');
    }
    notifyListeners();
  }

  Future<void> getimage() async {
    final pikImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pikImage == null) {
      return;
    } else {
      final imageTemp = File(pikImage.path);
      image = imageTemp;
      notifyListeners();
      log("image picked ");
    }
  }

  void isVisible(img) {
    if (img == null) {
      imageVisible = true;
    } else {
      imageVisible = false;
    }

    notifyListeners();
  }
}
