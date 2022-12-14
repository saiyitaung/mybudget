import 'package:flutter/material.dart';
import 'package:mybudget/widgets/categoryicon.dart';

class BudgetItem extends StatelessWidget {
  final IconData icondata;
  final Color iconbgColor;
  final String date;
  final String title;
  final String amount;
  final bool showSub;
  const BudgetItem(
      {Key? key,
      required this.icondata,
      required this.iconbgColor,
      required this.title,
      required this.date,
      this.showSub=true,
      required this.amount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: !showSub ? const EdgeInsets.only(top:5,):EdgeInsets.zero ,
      leading: Container(padding: const EdgeInsets.only(left:10),child:CategoryIcon(iconData: icondata,bgColor: iconbgColor,),),
      title: Text(title,style: TextStyle(fontFamily: "itim",fontSize: 24,color:  iconbgColor),),
      subtitle: showSub ? Text(date,style: const TextStyle(fontSize: 13,color:  Colors.white38),):null,
      trailing: Container(padding: const EdgeInsets.only(right: 20),child:Text("$amount",style: const TextStyle(fontFamily: "meriendaone"),),),
    );
  }
}
