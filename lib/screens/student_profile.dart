import 'package:flutter/material.dart';
import 'package:student_manager/screens/edit_student.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile(
      {Key? key,
      required this.name,
      required this.age,
      required this.email,
      required this.number,
      required this.index})
      : super(key: key);
  final String name;
  final String age;
  final String email;
  final String number;
  final int index;

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return EditStudent(
                    name: widget.name,
                    age: widget.age,
                    number: widget.number,
                    email: widget.email,
                    index: widget.index,
                    image: '',
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
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/student (2).png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.name.toUpperCase(),
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
                                  'NAME : ${widget.name}'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'AGE :${widget.age} ',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'EMAIL : ${widget.email}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Text(
                                  'PARANT NUMBER : ${widget.number}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
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
        ));
  }

  // Future<void> editButtonClicked() async {
  //   final name=
  // }
}
