import 'package:flutter/material.dart';
import 'task_page.dart';

void main() => runApp(IST());

class IST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: TaskPage(),
    );
  }
}


