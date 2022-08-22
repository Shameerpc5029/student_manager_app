import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_manager/db/functions/db_functions.dart';

import 'package:student_manager/db/model/student_model.dart';

class EditStudent extends StatefulWidget {
  const EditStudent({
    Key? key,
    required this.name,
    required this.age,
    required this.number,
    required this.email,
    required this.index,
    required this.image,
  }) : super(key: key);

  final String name;
  final String age;
  final String number;
  final String email;
  final int index;
  final String image;

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _ageController = TextEditingController();

  TextEditingController _numberController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> fromKey = GlobalKey();
  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _numberController = TextEditingController(text: widget.number);
    _emailController = TextEditingController(text: widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add Student Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        'assets/images/student (2).png',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add Image'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Full Name!";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Student Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Age!";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Student Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Parent's Mobile Number!";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      decoration: const InputDecoration(
                        labelText: "Parent's Mobile Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter Student Email";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Student Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                editedButton();
                              } else {
                                return;
                              }

                              _ageController.clear();
                              _emailController.clear();
                              _nameController.clear();
                              _numberController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.check,
                            ),
                            label: const Text(
                              'Save',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editedButton() async {
    final studentmodel = StudentModel(
      name: _nameController.text,
      age: _ageController.text,
      number: _numberController.text,
      email: _emailController.text,
    );
    editStudent(studentmodel, widget.index);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(
          seconds: 2,
        ),
        backgroundColor: Color.fromARGB(
          255,
          34,
          104,
          12,
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(
          10,
        ),
        content: Text(
          'Stundent Data Edited',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
