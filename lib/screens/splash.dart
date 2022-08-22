

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:student_manager/screens/home_screen.dart';

class SplashSreen extends StatefulWidget {
  const SplashSreen({Key? key}) : super(key: key);

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 250,
              image: AssetImage('assets/images/logo .png'),
            ),
            const Text(
              'ABC SCHOOL',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 132, 0),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'KUZHIMANNA',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 73, 132),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: LoadingAnimationWidget.flickr(
                  leftDotColor:const  Color.fromARGB(255, 255, 132, 0),
                  rightDotColor: Colors.blue,
                  size: 50),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) {
          return  const HomeScreen();
        },
      ),
    );
  }
}