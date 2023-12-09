// main.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'CalculatorPage.dart';
import 'ApiPage.dart';
import 'NotesPage.dart';
import 'TicTacToePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment-3-Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/calculator': (context) => CalculatorPage(),
        '/api': (context) => ApiPage(),
        '/notes': (context) => NotesPage(),
        '/TicTacToe': (context) => TicTacToePage(),
      },
    );
  }
}
