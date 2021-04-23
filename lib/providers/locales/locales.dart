// import 'package:carinspection/global/global.dart';
import 'package:flutter_bolierplate_example/helpers/helpers.dart';
// import 'package:carinspection/services/services.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeRepository = ChangeNotifierProvider.autoDispose<LocaleRepository>(
    (ref) => LocaleRepository());

class LocaleRepository extends BaseNotifier {
  // services
  // final NavigationService _navigator = locator<NavigationService>();

  Future<void> setLocale(String languageCode) async {
    await Inject.updateLocale(languageCode).then((_) => Inject.auth.onLocale());
    notifyListeners();
  }
}
