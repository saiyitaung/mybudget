import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyInfoUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
              child: Lottie.asset('lottiefile/no-data.json')               
            );
  }

}