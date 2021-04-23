import 'package:flutter_bolierplate_example/constants/constants.dart';
import 'package:flutter_bolierplate_example/global/locator.dart';
import 'package:flutter_bolierplate_example/i18n/i18n.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeChangeNotifierProvider<AuthenticationRepository>
    authRepository =
    ChangeNotifierProvider.autoDispose<AuthenticationRepository>(
        (ref) => AuthenticationRepository(i18n: ref.read(i18nRepository)));

class AuthenticationRepository extends BaseNotifier {
  final LocalStorageService _storage = locator<LocalStorageService>();
  final NavigationService _navigator = locator<NavigationService>();
  AuthGuardStatus _status = AuthGuardStatus.Loading;
  AuthGuardStatus get status => _status;

  AuthenticationRepository({I18nRepository i18n}) {
    i18n.setupLocale().then((isSuccess) {
      if (isSuccess) {
        if (_storage.accessToken != null) {
          _status = AuthGuardStatus.Authenticated;
          notifyListeners();
        } else {
          _status = AuthGuardStatus.NotAuthenticated;
          notifyListeners();
        }
      } else {
        _status = AuthGuardStatus.SelectedLanguage;
        notifyListeners();
      }
    }).catchError((error) {
      Log.wtf(error.toString());
    });
  }

  void onDone() async {
    _status = AuthGuardStatus.Authenticated;
    await _navigator.popAll();
    notifyListeners();
  }

  void onLocale() async {
    _status = AuthGuardStatus.NotAuthenticated;
    await _navigator.popAll();
    notifyListeners();
  }

  void onLogout() async {
    _status = AuthGuardStatus.NotAuthenticated;
    await _navigator.popAll();
    notifyListeners();
  }
}
