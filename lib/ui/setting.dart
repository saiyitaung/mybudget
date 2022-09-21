import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybudget/myproviders/currencychangeprovider.dart';
import 'package:mybudget/myproviders/datetypeprovider.dart';
import 'package:mybudget/myproviders/localeprovider.dart';
import 'package:mybudget/myproviders/settingprovider.dart';
import 'package:mybudget/ui/about.dart';
import 'package:mybudget/utils/localecurrency.dart';
import 'package:mybudget/widgets/datetoggleswitch.dart';
import 'package:mybudget/widgets/inputtext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingUI extends ConsumerWidget {
  const SettingUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picFile = File(ref.watch(settingProvider)["profilePic"]!);
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(children: [
        const SizedBox(
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
                              ? const AssetImage("img/profile.png")
                              : Image.file(picFile).image,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    child: const SizedBox(
                      height: 150,
                      width: 150,
                    ),
                    onTap: () async {
                    //  debugPrint("profile clicked");
                      final _picker = ImagePicker();
                      final pic =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pic!.name.isNotEmpty) {
                        final dirpath = await getExternalStorageDirectory();
                        final fullpath = "${dirpath!.path}/${pic.name}";
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
                style: const TextStyle(fontSize: 28, fontFamily: 'Itim'),
              ),
              IconButton(
                  onPressed: () async {
                    final ctl = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              contentPadding: const EdgeInsets.all(10),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              title: Container(
                                alignment: Alignment.center,
                                child:   Text(
                                  "${AppLocalizations.of(context)?.changeName}",
                                  style: const TextStyle(
                                      fontFamily: 'Itim',
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                              ),
                              children: [
                                InputTextWidget(
                                    label: "${AppLocalizations.of(context)?.name}",
                                    type: TextInputType.name,
                                    autoCompleteText: [],
                                    ctl: ctl),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Text("${AppLocalizations.of(context)?.cancel}"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Text("${AppLocalizations.of(context)?.save}"),
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
                  icon: const Icon(Icons.edit)),
            ],
          )),
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.date_range,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.date ?? ""),
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
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.language,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.language ?? ""),
          trailing: DropdownButton<String>(
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "my",
                child: Text("မြန်မာ"),
              ),
            ],
            value: ref.watch(localChangeProvider).currentLocal.toString(),
            onChanged: (l) {
             // print(l);
              ref.watch(localChangeProvider.notifier).change(Locale(l ?? "en"));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(AppLocalizations.of(context)?.language ?? ""),
              //   duration: const Duration(milliseconds: 300),
              // ));
            },
          ),
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.pin,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.pin ?? ""),
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Comming soon")));
          },
        ),
        const Divider(
          height: 1,
        ),
        ExpansionTile(
          leading: const Icon(
            Icons.calendar_month,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.defaultChartResult ?? ""),
          children: [
            Container(
                height: 60,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: DateToggle(
                  selectedDateType: ref.watch(dateTypeChangeNotifierProvider),
                )),
          ],
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.currency_exchange,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.currency ?? ""),
          trailing: SizedBox(
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
                            value: e,
                            child: Text(getCurrencyLocale(context, e)),
                          ))
                      .toList(),
                  value: selected.currency,
                  selectedItemBuilder: ((context) => currencies
                      .map((e) => Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getCurrencyLocale(context, e),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList()),
                  onChanged: (c) {
                    selected.change(c!);
                  });
            })),
          ),
        ),
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.info_outline_rounded,
            color: Colors.teal,
          ),
          title: Text(AppLocalizations.of(context)?.about ?? ""),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AboutUI())),
        ),
        
      ]),
    );
  }
}
