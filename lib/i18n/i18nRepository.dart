import 'dart:convert';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/models/models.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';

final i18nRepository =
    ChangeNotifierProvider<I18nRepository>((ref) => I18nRepository());

class I18nRepository extends BaseNotifier {
  // services
  // final ApiService _api = locator<ApiService>();
  final LocalStorageService _storage = locator<LocalStorageService>();

  Language _selectedLanguage;
  Language get selectedLanguage => _selectedLanguage;
  // methods
  Future<bool> setupLocale() async {
    if (_storage.selectedLanguage != null) {
      _selectedLanguage = _storage.selectedLanguage;
      await updateLocale(_storage.selectedLanguage.code);
      return true;
    }
    return false;
  }

  /// Set user's prefered language
  Future<bool> updateLocale(String languageCode) async {
    Map<String, dynamic> jsonDecodedBody = {};

    // get the json file in asset, rootBundle is from flutter's lib
    String language = await rootBundle.loadString(
      "languages/$languageCode.json",
    );

    jsonDecodedBody = await json.decode(language);
    _selectedLanguage = Language.fromJson({
      "code": languageCode,
      "value": jsonDecodedBody,
    });

    bool isSuccess = await _storage.setSelectedLanguage(_selectedLanguage);
    // _api.setLanguageCode(_selectedLanguage.code);
    notifyListeners();

    return isSuccess; // locale changed
  }

  // Translate text for localization
  String tt(
    String key, {
    dynamic value, // if only have single value
    Map<String, dynamic> data, // if have multiple value
  }) {
    try {
      List<String> branches = key.split(".");
      dynamic lastestNest = _selectedLanguage.value;

      if (lastestNest == null) return key;

      for (String branch in branches) {
        lastestNest = lastestNest[branch];
        bool isLastIndex = branch == branches.last;

        if ((lastestNest is String && !isLastIndex) ||
            (lastestNest is Map && isLastIndex) ||
            lastestNest == null) {
          lastestNest = key;
          break;
        }
      }

      if (value != null) {
        lastestNest = lastestNest.replaceAll("{value}", value.toString());
      }

      if (data?.isNotEmpty ?? false) {
        data.forEach((key, value) {
          lastestNest = lastestNest.replaceAll("{$key}", value.toString());
        });
      }

      return lastestNest ?? key;
    } catch (_) {
      Log.wtf({
        "key": key,
        "data": data,
        "language_code": _selectedLanguage?.code,
      });

      return key;
    }
  }
}
