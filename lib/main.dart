import 'package:flutter/material.dart';
import 'package:panchanga/views/home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Panchanga(
          // differenceDate: 0,
          ),
    );
  }
}
