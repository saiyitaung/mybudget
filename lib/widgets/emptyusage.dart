import 'package:flutter/material.dart';

class EmptyInfoUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
              child: Text("Empty"),
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
            );
  }

}