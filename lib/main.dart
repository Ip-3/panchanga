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
      home: Panchanga(
        differenceDate: date,
      ),
    );
  }
}
