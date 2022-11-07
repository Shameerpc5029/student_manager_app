import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manager/Model/db/model/enum_class.dart';
import 'package:student_manager/Controller/provider/student_provider.dart';
import 'package:student_manager/View/Add%20And%20Edit%20Screen/add_edit_student.dart';
import 'package:student_manager/View/widgets/snack_bar.dart';
import 'package:student_manager/View/widgets/style.dart';

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
                  'No Item Found!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return height10;
                },
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = value.dataFound[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListTile(
                      leading: Consumer<StudentProvider>(
                        builder: (context, value, child) {
                          return CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                              radius: 28,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: FileImage(
                                  File(data.photo),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Mobile Number - ${data.number}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                          shape: const RoundedRectangleBorder(

                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: ((context) {
                            return Column(

                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                                height20,
                                CircleAvatar(
                                  radius: 50,
                                  child: CircleAvatar(
                                    radius: 46,
                                    backgroundImage: FileImage(
                                      File(
                                        data.photo,
                                      ),
                                    ),
                                  ),
                                ),
                                height20,
                                Text(
                                  data.name.toUpperCase(),
                                  style: textStyle2,
                                ),
                                height10,
                                Text(
                                  'Age - ${data.age}',
                                  style: textStyle1,
                                ),
                                height10,
                                Text(
                                  'Number - ${data.number}',
                                  style: textStyle1,
                                ),
                                height10,
                                Text(
                                  'Email - ${data.email}@gmail.com',
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
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  label: const Text('Edit'),
                                ),
                              ],
                            );
                          }),
                        );
                      },
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
  showCupertinoModalPopup(
    context: context,
    builder: ((context) {
      return CupertinoAlertDialog(
        title: const Text(
          "Delete Student?",
          style: textStyle2,
        ),
        content: const Text(
          "This student will be permanently deleted from this list.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false).deleteData(
                index,
                context,
              );
              Provider.of<StudentProvider>(context, listen: false)
                  .getAllData(context);
              CustomSnackBar()
                  .snackBar(context, 'Successfully deleted!', Colors.red);

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
    }),
  );
}
