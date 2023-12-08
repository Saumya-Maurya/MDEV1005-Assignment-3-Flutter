import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          MyContextModel cm = MyContextModel(); // Renamed here
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _expression,
              style: const TextStyle(fontSize: 24),
            ),
          ),

          // Result
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _result,
              style: const TextStyle(fontSize: 24),
            ),
          ),

          // Calculator buttons
          Table(
            children: [
              TableRow(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              TableRow(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              TableRow(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              TableRow(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class MyContextModel extends ContextModel {
  @override
  double get value => 0.0;

  @override
  set value(double value) {}
}
