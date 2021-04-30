import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bolierplate_example/guards/guards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'global/locator.dart';
import 'helpers/device.dart';
import 'services/services.dart';
import 'utils/utils.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    GestureBinding.instance!.resamplingEnabled = true;
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // Handle flutter error
    FlutterError.onError = (FlutterErrorDetails details) {
      bool notImportantErros = details?.silent ?? true;

      if (!notImportantErros) {
        Log.error(
          "Important error",
          exception: details.exception,
          stackTrace: details.stack,
        );
      } else {
        Log.warning(
          "Not important error",
          exception: details.exception,
          stackTrace: details.stack,
        );
      }
    };

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]),
      // setup services
      setupLocator(),
    ]);

    runZonedGuarded(
        () async => runApp(ProviderScope(
              observers: [Log()], // for debugging
              child: MyApp(),
            )), (error, trace) {
      Log.error(
        "Async error",
        exception: error,
        stackTrace: trace,
      );
    });
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: Device.dismissKeyboard,
      child: MaterialApp(
        title: 'flutter_bolierplate_example',
        navigatorKey: locator<NavigationService>().key,
        debugShowCheckedModeBanner: false,
        home: AuthGuard(),
      ));
}
