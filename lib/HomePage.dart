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
        title: Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
        automaticallyImplyLeading: false, // Hide the back button on the home page
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome message
            Text(
              'Hello! Welcome to Our App!',
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 20), // Spacer

            // Image for aesthetics
            Container(
              height: 250,
              width: 250,
              child: Image.asset(
                'assets/luffy.png',
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20), // Spacer

            // Buttons to navigate to other pages
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

  // Helper method to build navigation buttons
  Widget _buildNavigationButton(BuildContext context, String buttonText, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), // Set the minimum size of the button
        padding: EdgeInsets.all(20), // Set padding for the button
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 18), // Adjust the fontSize for the button text
      ),
    );
  }
}
