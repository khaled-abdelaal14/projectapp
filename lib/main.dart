import 'package:flutter/material.dart';
import 'package:iti/views/login_page.dart';
import 'package:iti/views/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Food Recipe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orangeAccent,
        ),
        home: WelcomePage(),
        );
   }
}