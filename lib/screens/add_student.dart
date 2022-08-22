import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_manager/db/functions/db_functions.dart';
import 'package:student_manager/db/model/student_model.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  File _file = File("img");
  late PickedFile imageFile;
  final ImagePicker picker = ImagePicker();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numberController = TextEditingController();

  final _emailController = TextEditingController();

  GlobalKey<FormState> fromKey = GlobalKey();

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
                    (_file.path == 'img')
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'assets/images/student (2).png',
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_file),
                            radius: 50,
                          ),
                    TextButton(
                      onPressed: () {
                        uploadImage();
                      },
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
                                addButtonCicked();
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
                              'Add',
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

  Future<void> addButtonCicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final number = _numberController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty || age.isEmpty || number.isEmpty || email.isEmpty) {
      return;
    }

    final student = StudentModel(
      name: name,
      age: age,
      number: number,
      email: email,
    );
    addStudent(
      student,
    );

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
          'Stundent Data Added',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      setState(() {
        _file = selected;
      });
    }
  }
  
}
