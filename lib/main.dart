import 'package:flutter/material.dart';
import 'package:tugas/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Api',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
