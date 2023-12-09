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
      appBar: AppBar(
        title: Text('Home'),
        leading: Container(), // Empty container to hide the back button on the home page
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome Message
            Text('Hello! Welcome to Our App!'),


            // Image for Aesthetics
            SizedBox(height: 20),
            Image.asset(
              'assets/luffy.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),

            // Buttons to navigate to other pages
            SizedBox(height: 20),
            _buildNavigationButton(context, 'Calculator', CalculatorPage()),
            SizedBox(height: 10),
            _buildNavigationButton(context, 'Wallpapers', ApiPage()),
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
