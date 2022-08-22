import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_manager/db/model/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studnetDb = await Hive.openBox<StudentModel>('Student_db');
  final id = await studnetDb.add(value);
  value.id = id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final studnetDb = await Hive.openBox<StudentModel>('student_DB');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studnetDb.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStutent(index) async {
  final studnetDb = await Hive.openBox<StudentModel>('student_DB');
  await studnetDb.deleteAt(index);
  getAllStudents();
}

Future<void> editStudent(StudentModel value, int id) async {
  final studnetDb = await Hive.openBox<StudentModel>('Student_db');

  studnetDb.putAt(id, value);
  studentListNotifier.notifyListeners();
  getAllStudents();
}
