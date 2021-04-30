import 'dart:io';

import 'package:flutter_bolierplate_example/common/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bolierplate_example/global/locator.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';
import 'package:flutter_bolierplate_example/services/services.dart';
import 'package:flutter_bolierplate_example/helpers/device.dart';

class Dialogs {
  static final NavigationService _navigator = locator<NavigationService>();

  static Future<bool> _baseDialog({
    required String title,
    required String content,
    required List<Widget> actions,
    bool barrierDismissible = true,
  }) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: _navigator.overlayContext,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: actions,
            ),
          ) as bool
        : await showDialog(
            context: _navigator.overlayContext,
            barrierDismissible: barrierDismissible,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => barrierDismissible,
                child: AlertDialog(
                  title: Text(title.toString()),
                  content: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Device.maxWidth / 2,
                    ),
                    child: Text(content.toString()),
                  ),
                  actions: actions,
                ),
              );
            },
          ) as bool;
  }

  static Future<bool> confirmation({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
  }) async {
    return await _baseDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () => _navigator.pop(false),
          child: Text(
            (cancelText ?? 'ยกเลิก').toUpperCase(),
            style: TextStyle(
              color: ColorsList.blueActive,
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _navigator.pop(true),
          child: Text(
            (confirmText ?? 'ยืนยัน').toUpperCase(),
            style: TextStyle(
              color: ColorsList.blueActive,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  static Future<bool> notify({
    required String title,
    required String content,
    String? okayText,
    bool barrierDismissible = true,
  }) {
    return _baseDialog(
      title: title,
      content: content,
      barrierDismissible: barrierDismissible,
      actions: [
        TextButton(
          onPressed: () => _navigator.pop(true),
          child: Text(
            (okayText ?? 'ตกลง').toUpperCase(),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  static Future<T> loading<T>({
    required Future future,
    String? loadingText,
  }) async {
    Device.dismissKeyboard();

    showDialog(
      context: _navigator.overlayContext,
      barrierDismissible: true,
      builder: (_) {
        return WillPopScope(
            onWillPop: () async => false,
            child: Platform.isIOS
                ? Theme(
                    data: ThemeData(
                        cupertinoOverrideTheme:
                            CupertinoThemeData(brightness: Brightness.dark)),
                    child: CupertinoActivityIndicator(
                      radius: 15,
                    ))
                : Loading(size: 3));
      },
    );

    T response = await future;
    _navigator.pop();

    return response; // pop loading dialog
  }
}
