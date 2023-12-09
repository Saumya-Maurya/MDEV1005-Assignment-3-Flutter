import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Font size constant for consistency
  static const double _fontSize = 24.0;

  // Variables to store the input expression and calculation result
  String _expression = '';
  String _result = '';

  // Function to handle button presses
  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear the expression and result on 'C' button press
        _expression = '';
        _result = '';
      } else if (buttonText == '=') {
        // Evaluate the expression and update the result on '=' button press
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          MyContextModel cm = MyContextModel();
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          // Handle evaluation errors
          _result = 'Error';
        }
      } else {
        // Concatenate the button text to the expression
        _expression += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back arrow is pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display for expression
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _expression,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),

          // Result display
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _result,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),

          // Calculator buttons
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return _buildButton(buttons[index]);
            },
          ),
        ],
      ),
    );
  }

  // Function to build calculator buttons
  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey[700],
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: _fontSize, color: Colors.white),
      ),
    );
  }

  // List of calculator buttons
  List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    '0', 'C', '=', '+',
  ];
}

// Custom context model for math expressions
class MyContextModel extends ContextModel {
  @override
  double get value => 0.0;

  @override
  set value(double value) {}
}
