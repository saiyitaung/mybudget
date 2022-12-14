import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mybudget/entities/budget.dart';
import 'package:mybudget/entities/expense.dart';
import 'package:mybudget/entities/income.dart';
import 'package:mybudget/myproviders/localeprovider.dart';
// import 'package:mybudget/ui/home.dart';
import 'package:mybudget/ui/splashscreen.dart';
import 'package:mybudget/widgets/darktheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //android dir
  final dataPath = await getExternalStorageDirectory();
  await Hive.initFlutter(dataPath!.path);
  // linux dir
  // final dir=Directory("mybudget");
  // await Hive.initFlutter(dir.path);
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(InComeAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>("expensedb");
  await Hive.openBox<InCome>("incomedb");
  await Hive.openBox<String>("settingdb");

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 
  runApp(const ProviderScope(child: MyApp()));
  
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const[
       AppLocalizations.delegate,
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale('en',''),
        Locale('my','')
      ],
      title: 'my budget',
      theme: DarkTheme.darkTheme(),
      home:const SplashScreenUI(),
      locale: ref.watch(localChangeProvider).currentLocal,
    );
  }
}
