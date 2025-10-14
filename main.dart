import 'package:e_learning_platform/homescreen.dart';
import 'package:e_learning_platform/screens/login_screen3.dart';
import 'package:e_learning_platform/screens/search_course.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_platform/screens/login_screen.dart';
import 'onboarding_screens/onboarding_screens.dart';
import 'package:e_learning_platform/intro screen/create_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SearchCoursesScreen());
  }
}
