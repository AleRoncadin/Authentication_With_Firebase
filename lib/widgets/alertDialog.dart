import 'package:flutter/material.dart';
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class alertDialog extends StatelessWidget {
  final String title;
  final String content;

  alertDialog({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.black,
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        child: const Text('Okay'),
        )
      ],
    );
  }
}