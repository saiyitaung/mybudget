import 'dart:ui';

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  const CardWidget(
      {Key? key,
      required this.title,
      required this.amount,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child:BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 3,sigmaY: 3),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(.8),
              color.withOpacity(.3),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1.5,
            color: color.withOpacity(0.2),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title), Text("$amount")],
          ),
        ),
      ),
      ),
    );
  }
}
