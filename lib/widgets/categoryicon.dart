import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData iconData;
  final Color bgColor;

  const CategoryIcon(
      {Key? key, required this.iconData, this.bgColor = Colors.blueGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color:bgColor),
      padding: const EdgeInsets.all(5),
      child: Center(child:Icon(
        iconData,
        size: 35,
        color: Colors.white,
      ),),
    );
  }
}
