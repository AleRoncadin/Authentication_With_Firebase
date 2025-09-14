import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class textfield extends StatelessWidget {
  final String myText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final IconData icon;
  final bool obscureText;
  //final Function() onChanged;

  textfield({required this.myText, required this.textEditingController, required this.textInputType, required this.icon, required this.obscureText}); //, required this.onChanged

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: obscureText,
      //onChanged: (value) => onChanged,
      decoration: InputDecoration(
        hintText: myText,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
      )    
    );
  }
}