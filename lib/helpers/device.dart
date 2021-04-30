import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/services/services.dart';


class Device {
  static final NavigationService _navigator = locator<NavigationService>();
  static final double _devicePixelRatio = ui.window.devicePixelRatio;
  static final ui.Size _size = ui.window.physicalSize;

  static void dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(_navigator.overlayContext);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  static double get maxWidth {
    return MediaQuery.of(_navigator.context).size.width;
  }

  static double get maxHeight {
    return MediaQuery.of(_navigator.context).size.height;
  }

  static double get statusBarHeight {
    return MediaQuery.of(_navigator.context).padding.top;
  }

  static double get bodyHeight {
    return maxHeight - kToolbarHeight * 2;
  }

  static double get keyboardHeight {
    return MediaQuery.of(_navigator.context).viewInsets.bottom;
  }

  static bool get isMobile {
    return !isTablet;
  }

  static bool get isTablet {
    // logic from https://stackoverflow.com/a/61246548/13625577
    bool isFirstMode =
        _devicePixelRatio < 2 && (_size.width >= 1000 || _size.height >= 1000);
    bool isSecondMode =
        _devicePixelRatio == 2 && (_size.width >= 1920 || _size.height >= 1920);

    return isFirstMode || isSecondMode;
  }

  static bool get isPotrait {
    return MediaQuery.of(_navigator.context).orientation ==
        Orientation.portrait;
  }

  static bool get isLandscape {
    return MediaQuery.of(_navigator.context).orientation ==
        Orientation.landscape;
  }

  static Orientation get orientation {
    return MediaQuery.of(_navigator.context).orientation;
  }
}
