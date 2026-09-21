import 'package:flutter/material.dart';
import 'modul_02/ruang_praktikum.dart';

void main() {
  runApp(const PoliwangiStarterApp());
}

class PoliwangiStarterApp extends StatelessWidget {
  const PoliwangiStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poliwangi Starter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ruangpraktikum(),
    );
  }
}