import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buildTitle extends StatelessWidget{
  final String myText;
  buildTitle({required this.myText});

  @override
  Widget build(BuildContext context) { //widget con titolo della schermata
    return Center(
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Text(
              myText,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}