import 'package:flutter/material.dart';
import 'package:modul_03/pages/home_page.dart';
// import 'package:flutter/cuppertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belajar Navigasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // useMaterial3: true,
      home: HomePage(),
    );
  }
}
