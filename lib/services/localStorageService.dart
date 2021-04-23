import 'dart:convert';

import 'package:flutter_bolierplate_example/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_bolierplate_example/global/global.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  // Base =======================================================================
  T _getData<T>(String key) {
    if (_preferences == null) return null;
    T value = _preferences.get("${env.localStorageKey}_$key");
    return jsonDecode(value ?? "null");
  }

  Future<bool> _setData<T>(String key, T content) async {
    return await _preferences.setString(
      "${env.localStorageKey}_$key",
      jsonEncode(content),
    );
  }

  Future<bool> _removeData<T>(String key) async {
    return await _preferences.remove("${env.localStorageKey}_$key");
  }

  Future<void> removeAllData() async {
    await _preferences.clear();
  }
  // Auth =======================================================================

  String get accessToken {
    return _getData("accessToken") as String;
  }

  Future<void> setAccessToken(String value) async {
    return await _setData("accessToken", value);
  }

  Future<bool> removeAccessToken() async {
    return await _removeData("accessToken");
  }

  bool get biometricEnabled {
    var enabled = _getData(
      "biometricEnabled",
    );

    return enabled ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    return await _setData("biometricEnabled", value);
  }

  // Locale =======================================================================
  Language get selectedLanguage {
    var language = _getData("lang");
    return language != null ? Language.fromJson(language) : null;
  }

  Future<bool> setSelectedLanguage(Language value) async {
    return await _setData("lang", value.toJson());
  }
}
