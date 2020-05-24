
import 'package:flutter/material.dart';
import 'package:sbfood/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      title: 'SB Food',
      home: Home(),
    );
  }
}


