import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bolierplate_example/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/global/locator.dart';
import 'package:flutter_bolierplate_example/services/services.dart';

class Toast {
  static final NavigationService _navigator = locator<NavigationService>();

  static _baseToast({
    String? title,
    required Color backgroundColor,
    Color textColor = Colors.black,
    required String message,
    Function? onTap,
  }) {
    Flushbar? flush;
    Duration duration = Duration(seconds: (message.length % 5) + 3);

    flush = Flushbar<bool>(
      maxWidth: Device.maxWidth,
      titleText: title != null
          ? Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          : null,
      messageText: Text(
        message.toString(),
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0.0, 2.0),
          blurRadius: 12,
        ),
      ],
      duration: duration,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.all(Radius.circular(5)),
      mainButton: GestureDetector(
        onTap: () {
          flush!.dismiss(true);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.clear_rounded,
            size: 20,
            color: textColor,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: Duration(milliseconds: 300),
      dismissDirection: Platform.isIOS
          ? FlushbarDismissDirection.VERTICAL
          : FlushbarDismissDirection.HORIZONTAL,
      onTap: (_) {
        if (onTap != null) onTap();
      },
    );

    flush.show(_navigator.context);
  }

  static void error({
    IconData icon = Icons.error_outline_rounded,
    String? title,
    String? message,
  }) {
    _baseToast(
      title: title!,
      textColor: Colors.white,
      message: message ?? 'ERROR',
      backgroundColor: Colors.redAccent,
    );
  }

  static void success({
    String? title,
    required String message,
    Function? onTap,
  }) {
    _baseToast(
      title: title,
      textColor: Colors.white,
      message: message,
      backgroundColor: Colors.green,
      onTap: onTap!,
    );
  }

  static void info({
    String? title,
    required String message,
    Function? onTap,
  }) {
    _baseToast(
      title: title!,
      textColor: Colors.white,
      message: message,
      backgroundColor: Colors.lightBlue,
      onTap: onTap!,
    );
  }

  static void errorResponse(ApiResponse? response, {String? message}) {
    if (response!.code == 401) {
      error(
        message: 'หมดอายุในการเข้าถึงระบบ กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
      );
    } else if (response.code! >= 400 && response.code! <= 499) {
      error(
        message: message ?? 'พบข้อผิดพลาด กรุณาตรวจสอบ',
      );
    } else {
      switch (response.status) {
        case ResponseStatus.networkError:
          error(
            title: 'ไม่สามารถเข้าถึงเครือข่าย',
            message: 'ไม่สามารถเข้าถึงเครือข่ายได้',
          );
          break;

        default:
          error(
            message: 'พบข้อผิดพลาด กรุณาตรวจสอบ',
          );
      }
    }
  }
}
