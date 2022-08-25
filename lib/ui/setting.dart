import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';

class SettingUI extends ConsumerWidget {
  const SettingUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(children: [
        SizedBox(height: 30,),
        Container(
          height: 160,
          width: double.infinity,
          child: Center(
            child: Hero(
              tag: "p",
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("img/profile.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Center(
            child: Text(
              "Sai Yi",
              style: TextStyle(fontSize: 28),
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text("Date"),
          onTap: () {
            showDatePicker(
                builder: ((context, child) =>
                    Theme(data: ThemeData.dark(), child: child!)),
                context: context,
                initialDate: ref.read(dateStateNotifier),
                firstDate: DateTime(2021),
                lastDate: DateTime.now()).then((value) {
                  if(value != null){
                    ref.read(dateStateNotifier.notifier).state=value;
                  }
                });
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text("Language"),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(Icons.currency_exchange),
          title: Text("Currency"),
          trailing: DropdownButton<Currency>(
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            value: currencies.first,
              items: currencies
                  .map((e) => DropdownMenuItem(child: Text("${e.name}"),value: e,))
                  .toList(),
                  onChanged: (c){

                  },),
                  
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("About"),
        )
      ]),
    );
  }
}
