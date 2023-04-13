// import 'package:shared_preferences/shared_preferences.dart';
//
// class Shareprefrance {
//   Future<void> setBoolValue(String key, bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(key, value);
//   }
//
//   Future<bool?> getBoolValue(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? boolValue = prefs.getBool(key);
//     return boolValue;
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static late SharedPreferences prefsData;
  static String setSelectLeagueData = 'selectLeagueData';

  static Future initSharedPreferences() async {
    prefsData = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String value) async {
    await prefsData.setString(key, value);
  }



  static String getString(String key) {
    return prefsData.getString(key) ?? "";
  }




  static void clearData() async {
    await prefsData.clear();
  }
}
