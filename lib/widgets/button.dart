import 'package:flutter/material.dart';
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class Button extends StatelessWidget {
  final Function() selectHandler;
  final String buttonText;
  final Color color_text;
  final Color background_color;

  Button({required this.selectHandler, required this.buttonText, required this.color_text, required this.background_color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: this.background_color,
        // textColor: Colors.white,
        child: Text(
          htmlParser.DocumentFragment.html(buttonText).text.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color_text
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}