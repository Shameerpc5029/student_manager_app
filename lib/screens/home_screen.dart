import 'package:flutter/material.dart';
import 'package:student_manager/db/functions/db_functions.dart';
import 'package:student_manager/db/model/student_model.dart';
import 'package:student_manager/screens/add_student.dart';

import 'package:student_manager/screens/student_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getAllStudents();
    super.initState();
  }

  final searchController = TextEditingController();
  String query = '';
  List<StudentModel> studentSearchList = studentListNotifier.value.toList();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentList,
            Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Student Manager',
                style: TextStyle(color: Colors.white),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStudent()),
                );
              },
              child: const Icon(
                Icons.person_add,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: ((value) {
                        final student =
                            studentListNotifier.value.where((element) {
                          final nameLower = element.name.toLowerCase();
                          final age = element.age.toLowerCase();
                          final search = value.toLowerCase();
                          return nameLower.contains(search) ||
                              age.contains(search);
                        }).toList();
                        setState(() {
                          query = value;
                          studentSearchList = student;
                        });
                      }),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search Name & Age',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  if (studentList.isEmpty)
                    const Center(
                      child: Text(
                        'No items...',
                      ),
                    ),
                  Expanded(
                    child: (query.isEmpty == false && studentSearchList.isEmpty)
                        ? const Center(
                            child: Text('No results found'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final data = (query.isEmpty)
                                  ? studentList[index]
                                  : studentSearchList[index];

                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/student (2).png',
                                    ),
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
                                      deleteStutent(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((
                                          context,
                                        ) {
                                          return StudentProfile(
                                            name: data.name,
                                            age: data.age,
                                            email: data.email,
                                            number: data.number,
                                            index: index,
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            itemCount: (query.isEmpty)
                                ? studentList.length
                                : studentSearchList.length),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
