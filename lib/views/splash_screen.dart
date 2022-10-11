import 'package:flutter/material.dart';
import 'package:panchanga/views/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Panchanga(
              differenceDate: date,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 206, 73),
        body: Center(
          child: Image.asset("assets/1536x2048.png"),
        ));
  }
}
