import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_manager/db/model/enum_class.dart';
import 'package:student_manager/screens/add_edit_student.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile(
      {Key? key,
      required this.name,
      required this.age,
      required this.email,
      required this.number,
      required this.index,
      required this.id,
      required this.photo})
      : super(key: key);
  final String name;
  final String age;
  final String email;
  final String number;
  final int index;
  final String photo;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return AddStudent(
                  type: Actiontype.editScreen,
                  name: name,
                  age: age,
                  email: email,
                  number: number,
                  id: id.toString(),
                  image: photo,
                  index: index,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(photo)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 5,
                  child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                'NAME : $name'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'AGE :$age ',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'EMAIL : $email',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Text(
                                'PARANT NUMBER : $number',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
