import 'package:flutter/material.dart';
import 'package:modul_01/modul_01/profile_screen.dart';
// import 'package:flutter/cuppertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // useMaterial3: true,
      home: ProfileScreen(),
    );
  }
}
