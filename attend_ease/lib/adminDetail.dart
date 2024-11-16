import 'package:attend_ease/adminMain.dart';
import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)(
    return MaterialApp(
      home: CourseDetailedPage(),
    );
  )
}

class CourseDetailedPage extends StatelessWidget{
    Map <String,Object> courseData = {
      'Name':'JJJJJJJJava',
      'code':'CS6104'
    };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Bar'),
      ),
    );
  }
}