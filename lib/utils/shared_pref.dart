import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  Future<String?> getUserToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(token);
  }

  Future<bool?> setUserToken(String token, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(token, value);
  }
}
