import 'package:shared_preferences/shared_preferences.dart';

const String keyId = '@carmana_';
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Preferences preferences = Preferences();

class Preferences {
  // ------------------ SINGLETON -----------------------
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() => _preferences;
  Preferences._internal();

  /// ----------------------------------------------------------
  /// Generic fetch a preference
  /// ----------------------------------------------------------
  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(keyId + key) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic saves String  a preference
  /// ----------------------------------------------------------
  Future<bool> setString(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(keyId + name, value);
  }

  /// ----------------------------------------------------------
  /// Generic fetch Boolean by Key a preference
  /// ----------------------------------------------------------
  Future<bool> getBool(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getBool(keyId + name) ?? false;
  }

  /// ----------------------------------------------------------
  /// Generic saves Boolean a preference
  /// ----------------------------------------------------------
  Future<bool> setBool(String name, bool value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setBool(keyId + name, value);
  }

  /// ----------------------------------------------------------
  /// Generic fetch Int a preference
  /// ----------------------------------------------------------
  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getInt(keyId + key) ?? 0;
  }

  /// ----------------------------------------------------------
  /// Generic saves Int a preference
  /// ----------------------------------------------------------
  Future<bool> setInt(String name, int value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setInt(keyId + name, value);
  }

  /// ----------------------------------------------------------
  /// Generic get Double a preference
  /// ----------------------------------------------------------
  Future<double> getDouble(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getDouble(keyId + name) ?? 0.0;
  }

  /// ----------------------------------------------------------
  /// Generic setDouble a preference
  /// ----------------------------------------------------------
  Future<bool> setDouble(String name, double value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setDouble(keyId + name, value);
  }

  /// ----------------------------------------------------------
  /// Generic remove by key
  /// ----------------------------------------------------------
  Future<bool> removeByKey(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.remove(keyId + name);
  }

  /// ----------------------------------------------------------
  /// Generic clear prefs
  /// ----------------------------------------------------------
  Future<bool> clear() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.clear();
  }
}
