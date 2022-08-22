import 'package:flutter/material.dart';
import 'package:student_manager/db/functions/db_functions.dart';

import '../db/model/student_model.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final data = studentList[index];
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Text(data.name),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
            itemCount: studentList.length,
          ),
        );
      },
    );
  }
}
