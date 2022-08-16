import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/ui/newexp.dart';

class ExpenseUI extends ConsumerWidget{
  const ExpenseUI({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(title: const Text("Expense"),),
      body: Column(children: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> NewExpUI()));
        }, child: const Text("New"))
      ],),
    );
  }
}