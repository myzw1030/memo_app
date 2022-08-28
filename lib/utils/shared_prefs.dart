import 'package:shared_preferences/shared_preferences.dart';

class SharePrefs {
  // 文字列の型を作成
  static const listItems = 'list_items';

  static late SharedPreferences _sharedPreferences;

  static Future setInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //setStringList()によって変更されたデータを更新し、新しいデータが方に保存される。
  //getStringList()はinitState()(そのページに切り替わったとき)、SharedPreferenceから保存されたデータを呼び出す役割。
  static Future<bool> setListItems(List<String> value) =>
      _sharedPreferences.setStringList(listItems, value);
  static List<String> getListItems() =>
      _sharedPreferences.getStringList(listItems) ?? [];
}
