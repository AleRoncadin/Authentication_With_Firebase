import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class TextDisplay extends StatelessWidget {
  final String myText;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;
  final Color textColor;

  TextDisplay({required this.myText, required this.fontSize, required this.fontWeight, required this.textAlign, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      color: color,
      child: Text(
        htmlParser.DocumentFragment.html(myText).text.toString(),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor
        ),
        textAlign: textAlign
      ),
    );
  }
}