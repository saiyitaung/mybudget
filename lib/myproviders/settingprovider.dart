import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final settingBox = Hive.box<String>("settingdb");
const String profileName = "profileName";
const String profilePic = "profilePic";
const String defaultDateType = "defaultDateType";
const notfound ="notfound";

class SettingStateProvider extends StateNotifier<Map<String, String>> {
  SettingStateProvider(super.state);
  void changeName(String name) {
    state[profileName] = name;
    state = {...state};
    settingBox.put(profileName, name);
  }

  void changePice(String picUrl) {
    state[profilePic] = picUrl;
    state = {...state};
    settingBox.put(profilePic, picUrl);
  }

  void changeDefaultDateType(String dt) {
    state[defaultDateType] = dt;
    state = {...state};
    settingBox.put(defaultDateType, dt);
  }

}
final settingProvider =
    StateNotifierProvider<SettingStateProvider, Map<String, String>>(((ref) {
  return SettingStateProvider({
    profileName: settingBox.get(profileName) ?? notfound,
    profilePic: settingBox.get(profilePic) ?? notfound,
    defaultDateType: settingBox.get(defaultDateType) ?? "month",
  });
}));
