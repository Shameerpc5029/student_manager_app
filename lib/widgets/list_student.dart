import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/db/model/enum_class.dart';

import 'package:student_manager/provider/student_provider.dart';
import 'package:student_manager/screens/add_edit_student.dart';
import 'package:student_manager/screens/student_profile.dart';
import 'package:student_manager/widgets/style.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, value, child) {
        return value.dataFound.isEmpty
            ? const Center(
                heightFactor: 30,
                child: Text(
                  'No results found!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = value.dataFound[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      child: ListTile(
                        leading: Consumer<StudentProvider>(
                          builder: (context, value, child) {
                            return CircleAvatar(
                              radius: 25,
                              backgroundImage: FileImage(
                                File(data.photo),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          data.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'AGE : ${data.age}',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            onPressedDelete(context, data.id.toString());
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((context) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                  height20,
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        FileImage(File(data.photo)),
                                  ),
                                  height20,
                                  Text(
                                    'NAME :${data.name}'.toUpperCase(),
                                    style: textStyle1,
                                  ),
                                  height20,
                                  Text(
                                    'AGE :${data.age}'.toUpperCase(),
                                    style: textStyle1,
                                  ),
                                  height20,
                                  Text(
                                    'NUMBER :${data.number}'.toUpperCase(),
                                    style: textStyle1,
                                  ),
                                  height20,
                                  Text(
                                    'EMAIL :${data.email}'.toUpperCase(),
                                    style: textStyle1,
                                  ),
                                  height20,
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AddStudent(
                                                type: Actiontype.editScreen,
                                                name: data.name,
                                                age: data.age,
                                                email: data.email,
                                                number: data.number,
                                                id: data.id.toString(),
                                                image: data.photo,
                                                index: index,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                      label: Text('Edit')),
                                ],
                              );
                            }),
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: ((
                          //       context,
                          //     ) {
                          //       return StudentProfile(
                          //         photo: data.photo,
                          //         id: data.id.toString(),
                          //         name: data.name,
                          //         age: data.age,
                          //         email: data.email,
                          //         number: data.number,
                          //         index: index,
                          //       );
                          //     }),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  );
                },
                itemCount: value.dataFound.length,
              );
      },
    );
  }
}

void onPressedDelete(BuildContext context, String index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Want to delete ?"),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false).deleteData(
                index,
                context,
              );
              Provider.of<StudentProvider>(context, listen: false)
                  .getAllData(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Successfully deleted !'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.blue,
                ),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
