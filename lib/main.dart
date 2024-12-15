import 'package:flutter/material.dart';
import 'package:skill_test_q1/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Flutter App',
      home: const HomeScreen(),
    );
  }
}
