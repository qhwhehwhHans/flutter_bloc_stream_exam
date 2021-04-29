import 'package:flutter/material.dart';
import 'package:flutter_app_test/src/random_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: RandomList(),
    );
  }
}

