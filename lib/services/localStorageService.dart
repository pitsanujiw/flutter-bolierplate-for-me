import 'dart:convert';

import 'package:flutter_bolierplate_example/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_bolierplate_example/global/global.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  // Base =======================================================================
  T? _getData<T>(String key) {
    if (_preferences == null) return null;
    Object? value = _preferences!.get("${env.localStorageKey}_$key");
    return value != null ? jsonDecode(value as String) : null;
  }

  Future<bool> _setData<T>(String key, T content) async {
    return await _preferences!.setString(
      "${env.localStorageKey}_$key",
      jsonEncode(content),
    );
  }

  Future<bool> _removeData<T>(String key) async {
    return await _preferences!.remove("${env.localStorageKey}_$key");
  }

  Future<void> removeAllData() async {
    await _preferences!.clear();
  }
  // Auth =======================================================================

  String? get accessToken {
    String? accessToken = _getData("accessToken");
    return accessToken != null ? accessToken : null;
  }

  Future<void> setAccessToken(String value) async {
    await _setData("accessToken", value);
  }

  Future<List<bool>> removeAccessToken() async {
    return await Future.wait([
      _removeData("accessToken"),
    ]);
  }

  // Future maybe use BIOMETRIC AUTHENTICATION =======================================

  bool get biometricEnabled {
    var enabled = _getData(
      "biometricEnabled",
    );

    return enabled ?? false;
  }

  Future<void> setBiometricEnabled(bool value) async {
    await _setData("biometricEnabled", value);
  }

  // Locale =======================================================================
  Language? get selectedLanguage {
    var language = _getData("lang");
    return language != null ? Language.fromJson(language) : null;
  }

  Future<bool> setSelectedLanguage(Language value) async {
    return await _setData("lang", value.toJson());
  }
}
