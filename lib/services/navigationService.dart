import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  // states
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get key => _navigatorKey;

  /// The build context of the current state
  BuildContext get context => _navigatorKey.currentState!.context;

  /// The build context for overlays
  BuildContext get overlayContext =>
      _navigatorKey.currentState!.overlay!.context;

  void _unfocus() {
    FocusScopeNode currentFocus = FocusScope.of(overlayContext);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<T?> push<T extends Object>(
    Widget view, {
    bool fullscreenDialog = false,
  }) async {
    _unfocus();

    await Future.delayed(Duration(milliseconds: 100));

    return _navigatorKey.currentState!.push(
      Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            )
          : MaterialPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            ),
    ) as Future<T?>;
  }

  Future<T> pushReplacement<T extends Object>(
    Widget view, {
    bool fullscreenDialog = false,
  }) async {
    _unfocus();

    return await _navigatorKey.currentState!.pushReplacement(
      Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            )
          : MaterialPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            ),
    ) as T;
  }

  Future<T> pushAndRemoveUntil<T extends Object>(
    Widget view, {
    bool fullscreenDialog = false,
  }) async {
    _unfocus();

    return await _navigatorKey.currentState!.pushAndRemoveUntil(
      Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            )
          : MaterialPageRoute(
              builder: (context) => view,
              fullscreenDialog: fullscreenDialog,
            ),
      (Route<dynamic> route) => route.isFirst,
    ) as T;
  }

   T? pop<T extends Object?>([T? result]) {
    _unfocus();
    _navigatorKey.currentState!.pop(result ?? true);
  }

  Future<void> popAll() async {
    _unfocus();

    return _navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
