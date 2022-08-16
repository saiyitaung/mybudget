import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  const CardWidget({Key? key, required this.title, required this.amount,required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color.withOpacity(.8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(title), Text("$amount")],
        ),
      ),
    );
  }
}
