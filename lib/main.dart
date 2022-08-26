import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mybudget/entities/budget.dart';
 
import 'package:mybudget/entities/expense.dart';
 
import 'package:mybudget/entities/income.dart';
 
import 'package:mybudget/ui/home.dart';
import 'package:mybudget/widgets/darktheme.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //final dataPath=await getExternalStorageDirectory();
  final dir=Directory("mybudget");
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(InComeAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>("expensedb");
  await Hive.openBox<InCome>("incomedb");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my budget',
            theme: DarkTheme.darkTheme(),             
      home:   HomePage(),

    );
  }
}

 
 