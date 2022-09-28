import 'package:flutter/material.dart';
import 'package:panchanga/views/home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color.fromARGB(255, 247, 206, 73),
      home: Panchanga(
        differenceDate: date,
      ),
      // home: SplashScreen(
      //     seconds: 8,
      //     navigateAfterSeconds: Panchanga(
      //       differenceDate: date,
      //     ),
      //     title: new Text(
      //       'UM Panchanaga',
      //       style: new TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20.0,
      //           color: Colors.white),
      //     ),
      //     backgroundColor: Colors.lightBlue[200],
      //     image: new Image.asset('assets//Users/pthinks/Documents/Jhenkar/FlutterExamples/panchanga/assets/1536x2048.png.png'),
      //     photoSize: 100.0,
      //     styleTextUnderTheLoader: new TextStyle(),
      //     loaderColor: Colors.white),
    );
  }
}
