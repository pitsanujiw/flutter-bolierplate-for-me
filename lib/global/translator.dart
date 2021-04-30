import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/i18n/i18n.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Similar to Inject() util, but this is not a static method
String t(String key, {dynamic value, Map<String, dynamic>? data}) {
  return locator<NavigationService>().context.read(i18nRepository).tt(
        key,
        value: value,
        data: data,
      );
}
