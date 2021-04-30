import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/authentication/authentication.dart';
import 'package:flutter_bolierplate_example/i18n/i18n.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Inject {
  static final NavigationService _navigator = locator<NavigationService>();

  static AuthenticationRepository get auth {
    return _navigator.context.read(authRepository);
  }

  static I18nRepository get i18n {
    return _navigator.context.read(i18nRepository);
  }

  static String get selectedLanguageCode {
    return _navigator.context.read(i18nRepository).selectedLanguage.code;
  }

  static Future<void> initialLocate() async {
    try {
      await _navigator.context.read(i18nRepository).setupLocale();
    } catch (e) {
      Log.wtf(e.toString());
    }
  }

  static Future<void> updateLocale(String languageCode) async {
    await _navigator.context.read(i18nRepository).updateLocale(languageCode);
  }
}
