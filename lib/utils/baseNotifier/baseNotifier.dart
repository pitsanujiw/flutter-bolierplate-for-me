import 'package:flutter/material.dart';

class BaseNotifier extends ChangeNotifier {
  bool? _isDisposed = false;
  bool get isDisposed => _isDisposed ?? false;

  @protected
  @mustCallSuper
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
