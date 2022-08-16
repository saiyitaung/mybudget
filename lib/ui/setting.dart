import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingUI extends ConsumerWidget{
  const SettingUI({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"),),
    );
  }
}