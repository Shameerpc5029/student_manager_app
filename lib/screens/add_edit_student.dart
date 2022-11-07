import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/db/functions/db_functions.dart';
import 'package:student_manager/db/model/enum_class.dart';
import 'package:student_manager/db/model/student_model.dart';
import 'package:student_manager/provider/student_provider.dart';
import 'package:student_manager/screens/home_screen.dart';
import 'package:student_manager/widgets/style.dart';

class AddStudent extends StatelessWidget {
  AddStudent({
    Key? key,
    this.name,
    this.age,
    this.email,
    this.number,
    this.image,
    this.index,
    this.id,
    required this.type,
  }) : super(key: key);

  final Actiontype type;
  final String? name;
  final String? age;
  final String? email;
  final String? number;
  final String? image;
  final int? index;
  final String? id;
  // File _file = File("img");

  // late PickedFile imageFile;

  // final ImagePicker picker = ImagePicker();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numberController = TextEditingController();

  final _emailController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (type == Actiontype.editScreen) {
      _nameController.text = name.toString();
      _ageController.text = age.toString();
      _emailController.text = email.toString();
      _numberController.text = number.toString();
    }
    final imagePicker = Provider.of<StudentProvider>(context, listen: false);

    if (type == Actiontype.addScreen) {
      imagePicker.image == null;
    }

    imagePicker.imageVisible = false;

    return Scaffold(
      appBar: AppBar(
        title: type == Actiontype.addScreen
            ? const Text(
                "Add Student Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )
            : const Text(
                "Edit Student Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Consumer<StudentProvider>(
                          builder: (context, value, child) {
                            return type == Actiontype.editScreen
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      File(
                                        value.image?.path ?? image!,
                                      ),
                                    ),
                                  )
                                : value.image == null
                                    ? const CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                          kImage,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        child: CircleAvatar(
                                          radius: 48,
                                          backgroundImage: FileImage(
                                            File(
                                              value.image!.path,
                                            ),
                                          ),
                                        ),
                                      );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            imagePicker.getimage();
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 16,
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    height10,
                    Consumer<StudentProvider>(
                      builder: (context, value, child) {
                        return Visibility(
                          visible: value.imageVisible,
                          child: const Text(
                            'Add Image!',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                    height20,
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "   Enter Student Full Name!";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        labelText: 'Student Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "   Enter Student Age!";
                        } else if (value.length > 2) {
                          return "   Enter Student Age Correct Format";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                        labelText: 'Student Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "   Enter Parent's Mobile Number!";
                        } else if (value.length != 10) {
                          return "   Mobile number must be of 10 digit";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.number,
                      controller: _numberController,
                      decoration: const InputDecoration(
                        prefixText: '+91 ',
                        prefixIcon: Icon(Icons.phone_android_rounded),
                        labelText: "Parent's Mobile Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "   Enter Student Email";
                        } else {
                          return null;
                        }
                      }),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        suffixText: '@gmail.com  ',
                        labelText: 'Student Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                              if (type == Actiontype.addScreen) {
                                if (formKey.currentState!.validate() &&
                                    imagePicker.image != null) {
                                  addButtonCicked(context);
                                  imagePicker.imageVisible = false;
                                } else {
                                  if (imagePicker.image != null) {
                                    imagePicker.isVisible(imagePicker.image);
                                  } else {
                                    imagePicker.isVisible(imagePicker.image);
                                  }
                                }
                              } else {
                                if (formKey.currentState!.validate()) {
                                  addButtonCicked(context);
                                  imagePicker.imageVisible = false;
                                }
                              }
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

  Future<void> addButtonCicked(context) async {
    final imagePicker = Provider.of<StudentProvider>(context, listen: false);
    final studentFunction = Provider.of<StudentDb>(context, listen: false);

    final disName = _nameController.text.trim();
    final disAge = _ageController.text.trim();
    final disNumber = _numberController.text.trim();
    final disEmail = _emailController.text.trim();

    if (disName.isEmpty ||
        disAge.isEmpty ||
        disNumber.isEmpty ||
        disEmail.isEmpty) {
      return;
    } else {
      final student = StudentModel(
        photo: imagePicker.image?.path ?? image.toString(),
        name: disName,
        age: disAge,
        number: disNumber,
        email: disEmail,
        id: type == Actiontype.addScreen
            ? DateTime.now().microsecondsSinceEpoch.toString()
            : id.toString(),
      );
      type == Actiontype.addScreen
          ? studentFunction
              .addStudent(student)
              .then((value) => imagePicker.image = null)
          : studentFunction
              .editStudent(index!.toInt(), student, context)
              .then((value) => imagePicker.image = null);
      if (type == Actiontype.editScreen) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ), (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully edited records'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            backgroundColor: Colors.blue,
          ),
        );
      } else {
        Provider.of<StudentProvider>(context, listen: false)
            .getAllData(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully added'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            backgroundColor: Colors.blue,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }
}
