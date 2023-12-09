// main.dart
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'CalculatorPage.dart';
import 'ApiPage.dart';
import 'NotesPage.dart';
import 'TicTacToePage.dart';

void main() => runApp(const MyApp());

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment-3-Flutter',
      initialRoute: '/',
      routes: {
        // Home page route
        '/': (context) => HomePage(),

        // Calculator page route
        '/calculator': (context) => CalculatorPage(),

        // API page route
        '/api': (context) => ApiPage(),

        // Notes page route
        '/notes': (context) => NotesPage(),

        // TicTacToe page route
        '/TicTacToe': (context) => TicTacToePage(),
      },
    );
  }
}
