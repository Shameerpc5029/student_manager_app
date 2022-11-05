import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_manager/db/model/enum_class.dart';
import 'package:student_manager/provider/student_provider.dart';
import 'package:student_manager/screens/add_edit_student.dart';
import 'package:student_manager/widgets/list_student.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   getAllStudents();
  //   super.initState();
  // }

  final searchController = TextEditingController();

  // String query = '';

  // List<StudentModel> studentSearchList = studentListNotifier.value.toList();

  @override
  Widget build(BuildContext context) {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        studentProvider.getAllData(context);
        log("message");
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Consumer<StudentProvider>(
          builder: (context, value, child) {
            return CupertinoSearchTextField(
              itemColor: Colors.black,
              backgroundColor: Colors.white,
              controller: searchController,
              onChanged: (value) {
                StudentProvider().search(value);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<StudentProvider>().image = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudent(
                type: Actiontype.addScreen,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.person_add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: const [
              // Padding(
              //   padding: const EdgeInsets.all(20),

              //   // child: TextFormField(
              //   //   controller: searchController,
              //   //   onChanged: ((value) {
              //   //     final student =
              //   //         studentListNotifier.value.where((element) {
              //   //       final nameLower = element.name.toLowerCase();
              //   //       final age = element.age.toLowerCase();
              //   //       final search = value.toLowerCase();
              //   //       return nameLower.contains(search) ||
              //   //           age.contains(search);
              //   //     }).toList();
              //   //     setState(() {
              //   //       query = value;
              //   //       studentSearchList = student;
              //   //     });
              //   //   }),
              //   //   decoration: InputDecoration(
              //   //     contentPadding:
              //   //         const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              //   //     prefixIcon: const Icon(Icons.search),
              //   //     hintText: 'Search Name & Age',
              //   //     border: OutlineInputBorder(
              //   //         borderRadius: BorderRadius.circular(50)),
              //   //   ),
              //   // ),
              // ),
              // if (studentList.isEmpty)
              //   const Center(
              //     child: Text(
              //       'No items...',
              //     ),
              //   ),

              StudentList(),
            ],
          ),
        ),
      ),
    );
  }
}
