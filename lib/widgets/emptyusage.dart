import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyInfoUI extends StatelessWidget{
  const EmptyInfoUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
              child: Lottie.asset('lottiefile/no-data.json')               
            );
  }

}