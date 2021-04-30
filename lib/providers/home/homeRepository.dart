import 'package:flutter_bolierplate_example/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeChangeNotifierProvider<HomeRepository> homeRepository =
    ChangeNotifierProvider.autoDispose<HomeRepository>(
        (ref) => HomeRepository());

class HomeRepository extends BaseNotifier {
  String? _title;

  String? get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }
}
