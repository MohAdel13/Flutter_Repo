import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper{
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setIsDark(bool isDark)async{
    return await sharedPreferences.setBool('isDark', isDark);
  }

  static bool? getIsDark(){
    return sharedPreferences.getBool('isDark');
  }
}