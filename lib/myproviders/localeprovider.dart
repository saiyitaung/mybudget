import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mybudget/myproviders/settingprovider.dart';


final settingBox = Hive.box<String>("settingdb");
class LocaleProvider extends ChangeNotifier{
  Locale currentLocal= Locale(settingBox.get('language') ?? "en");
  change(Locale locale){
    currentLocal=locale;
    settingBox.put("language",locale.languageCode);
    notifyListeners();
  }
}

final localChangeProvider=ChangeNotifierProvider((ref) => LocaleProvider());