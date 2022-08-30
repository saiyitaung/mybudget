import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/settingprovider.dart';
import 'package:mybudget/ui/about.dart';
import 'package:mybudget/widgets/datetoggleswitch.dart';
import 'package:mybudget/widgets/inputtext.dart';
import 'package:path_provider/path_provider.dart';

class SettingUI extends ConsumerWidget {
  const SettingUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picFile = File(ref.watch(settingProvider)["profilePic"]!);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Container(
            height: 160,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Hero(
                    tag: "p",
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: ref.watch(settingProvider)["profilePic"]! ==
                                  "notfound"
                              ? AssetImage("img/profile.png")
                              : Image.file(picFile).image,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 150,
                      width: 150,
                    ),
                    onTap: () async {
                      debugPrint("profile clicked");
                      final _picker = ImagePicker();
                      final pic =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pic!.name.isNotEmpty) {
                        final dirpath = await getExternalStorageDirectory();
                        final fullpath = dirpath!.path + "/" + pic.name;
                        final oldFile =
                            ref.watch(settingProvider)["profilePic"]!;
                        File f = File(oldFile);
                        if (await f.exists()) {
                          await f.delete();
                        }
                        await pic.saveTo(fullpath);
                        ref
                            .watch(settingProvider.notifier)
                            .changePice(fullpath);
                      }
                    },
                  ),
                )
              ],
            )),
        Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ref.watch(settingProvider)["profileName"] == "notfound"
                    ? "John Doe"
                    : ref.watch(settingProvider)["profileName"]!,
                style: TextStyle(fontSize: 28, fontFamily: 'Itim'),
              ),
              IconButton(
                  onPressed: () async {
                    final ctl = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: Container(
                                child: Text(
                                  "Change Name",
                                  style: TextStyle(
                                      fontFamily: 'Itim',
                                      fontSize: 28,
                                      color: Colors.white),
                                ),
                                alignment: Alignment.center,
                              ),
                              children: [
                                InputTextWidget(
                                    label: "Name",
                                    type: TextInputType.name,
                                    autoCompleteText: [],
                                    ctl: ctl),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Text("Save"),
                                          onPressed: () {
                                            if (ctl.text.isNotEmpty) {
                                              ref
                                                  .watch(
                                                      settingProvider.notifier)
                                                  .changeName(ctl.text);
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ));
                  },
                  icon: Icon(Icons.edit)),
            ],
          )),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.date_range,
            color: Colors.teal,
          ),
          title: Text("Date"),
          onTap: () {
            showDatePicker(
                    builder: ((context, child) =>
                        Theme(data: ThemeData.dark(), child: child!)),
                    context: context,
                    initialDate: ref.read(dateStateNotifier),
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now())
                .then((value) {
              if (value != null) {
                ref.read(dateStateNotifier.notifier).state = value;
              }
            });
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.language,
            color: Colors.teal,
          ),
          title: Text("Language"),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Comming soon")));
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.pin,
            color: Colors.teal,
          ),
          title: Text("setup pin"),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Comming soon")));
          },
        ),
        Divider(
          height: 1,
        ),
        ExpansionTile(
          leading: Icon(
            Icons.calendar_month,
            color: Colors.teal,
          ),
          title: Text("Default Chart type"),
          children: [
            Container(
                height: 60,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: DateToggle(
                  selectedDateType: ref.watch(dateTypeChangeNotifierProvider),
                )),
          ],
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.currency_exchange,
            color: Colors.teal,
          ),
          title: Text("Currency"),
          trailing: Container(
            width: 150,
            child: Consumer(builder: ((context, ref, child) {
              final selected = ref.watch(currencyChangeNotifier);
              return DropdownButton<Currency>(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  underline: Container(
                    height: .5,
                    color: Colors.blue,
                  ),
                  isExpanded: true,
                  iconSize: 35,
                  iconEnabledColor: Colors.white70,
                  items: currencies
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name.toString()),
                            value: e,
                          ))
                      .toList(),
                  value: selected.currency,
                  selectedItemBuilder: ((context) => currencies
                      .map((e) => Container(
                            child: Text(
                              "${e.name}",
                              style: TextStyle(color: Colors.white),
                            ),
                            padding: EdgeInsets.only(
                              left: 20,
                            ),
                            alignment: Alignment.centerLeft,
                          ))
                      .toList()),
                  onChanged: (c) {
                    selected.change(c!);
                  });
            })),
          ),
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            Icons.info_outline_rounded,
            color: Colors.teal,
          ),
          title: Text("About"),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutUI())),
        )
      ]),
    );
  }
}
