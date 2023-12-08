// HomePage.dart
import 'package:flutter/material.dart';
import 'CalculatorPage.dart';
import 'ApiPage.dart';
import 'NotesPage.dart';
import 'TicTacToePage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Message
            Text('Welcome to the Home Page!'),

            // Buttons to navigate to other pages
            SizedBox(height: 20),
            _buildNavigationButton(context, 'Calculator', CalculatorPage()),
            SizedBox(height: 10),
            _buildNavigationButton(context, 'API', ApiPage()),
            SizedBox(height: 10),
            _buildNavigationButton(context, 'Notes', NotesPage()),
            SizedBox(height: 10),
            _buildNavigationButton(context, 'TicTacToe', TicTacToePage()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String buttonText, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(buttonText),
    );
  }
}
