import 'package:flutter/material.dart';
import 'package:panchanga/views/splash_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Color.fromARGB(255, 247, 206, 73),
      home: SplashScreen(),
    );
  }
}
