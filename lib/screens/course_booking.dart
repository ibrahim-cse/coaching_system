import 'dart:io';
import 'package:coaching_system/common/course_card.dart';
import 'package:coaching_system/common/logout_promt.dart';
import 'package:coaching_system/screens/payment.dart';
import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  String dirPath = '';
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          FlatButton(
            onPressed: () {
              logoutChoiceDialog(context);
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              CourseCard(
                courseTitle: const Text('Flutter Development'),
                courseSubtitle: const Text('Flutter tutorials for beginners.'),
                enrollTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Payment()));
                },
                // add2list: 'ADD TO LIST',
                // enrolled: 'ENROLL',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
