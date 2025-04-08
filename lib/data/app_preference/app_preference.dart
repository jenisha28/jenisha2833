import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static late SharedPreferences _preferences;

  static sharedInstance() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setPreference(var key, dynamic value) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else {
      return false;
    }
    return true;
  }

  static getPreference(var key) {
    dynamic result = _preferences.get(key);
    return result;
  }

  static clearPreference() {
    _preferences.clear();
  }

  static remove(var key) {
    _preferences.remove(key);
  }

  static bool isExist(var key) {
    return _preferences.containsKey(key);
  }

  static getKeys() {
    return _preferences.getKeys();
  }
}

class AppPreferences {
  static final String login = 'user_preference_key';
}