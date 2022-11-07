import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_manager/db/model/enum_class.dart';
import 'package:student_manager/provider/student_provider.dart';
import 'package:student_manager/screens/add_edit_student.dart';
import 'package:student_manager/widgets/list_student.dart';
import 'package:student_manager/widgets/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final searchController = TextEditingController();

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
          toolbarHeight: 100,
          title: Column(
            children: [
              const Text(
                'Student List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              height10,
              Consumer<StudentProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CupertinoSearchTextField(
                      itemSize: 18,
                      placeholder: 'Search Students',
                      placeholderStyle: textStyle1,
                      itemColor: Colors.grey,
                      controller: searchController,
                      onChanged: (result) {
                        value.search(result);
                      },
                    ),
                  );
                },
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
              StudentList(),
            ],
          ),
        ),
      ),
    );
  }
}
