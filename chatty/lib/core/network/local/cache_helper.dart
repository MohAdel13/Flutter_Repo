import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setData(String key, dynamic value)async{
    if(value is String){
      return await sharedPreferences.setString(key, value);
    }
    else if(value is bool){
      return await sharedPreferences.setBool(key, value);
    }
    else if(value is int){
      return await sharedPreferences.setInt(key, value);
    }
    else if(value is double){
      return await sharedPreferences.setDouble(key, value);
    }
  }

  static Object? getData(String key){
    return sharedPreferences.get(key);
  }

  static void removeData(String key)async{
    await sharedPreferences.remove(key);
  }
}