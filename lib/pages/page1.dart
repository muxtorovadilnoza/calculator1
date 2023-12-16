import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String _input = '';
  double _result = 0.0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _input = '';
        _result = 0.0;
      } else if (buttonText == '<=') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          _result = eval(_input);
          _input = _result.toString();
        } catch (e) {
          _result = 0.0;
          _input = 'Error';
        }
      } else {
        _input += buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(18.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Divider(),
          GridView.builder(

            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: buttonValues.length,
            itemBuilder: (BuildContext context, int index) {
              return CalculatorButton(
                buttonText: buttonValues[index],
                onPressed: () {
                  _onButtonPressed(buttonValues[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CalculatorButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText,style: TextStyle(fontSize: 25),),
    );
  }
}

double eval(String expression) {
  Parser p = Parser();
  Expression exp = p.parse(expression);
  ContextModel cm = ContextModel();
  return exp.evaluate(EvaluationType.REAL, cm);
}



const List<String> buttonValues = [
  'AC', '<=', '%', '/',
  '7', '8', '9', '*',
  '4', '5', '6', '-',
  '1', '2', '3', '+',
  "0",".",'=',
];