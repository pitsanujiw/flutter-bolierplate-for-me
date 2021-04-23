// import 'dart:async';

import 'package:flutter_bolierplate_example/authentication/authentication.dart';
import 'package:flutter_bolierplate_example/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bolierplate_example/constants/constants.dart';

class AuthGuard extends StatefulWidget {
  @override
  _AuthGuardState createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  @override
  initState() {
    super.initState();
    Inject.initialLocate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, Function<T>(ProviderBase<Object, T>) watch, _) {
      final mediaQuery = MediaQuery.of(context);
      final auth = watch(authRepository);
      Widget handleStateView() {
        switch (auth.status) {
          case AuthGuardStatus.NotAuthenticated:
            return HomeScreen();
          case AuthGuardStatus.Authenticated:
            return HomeScreen();
          case AuthGuardStatus.SelectedLanguage:
            return HomeScreen();
          default:
            return Scaffold(backgroundColor: Colors.white);
        }
      }

      return MediaQuery(
          data: mediaQuery.copyWith(
            textScaleFactor: mediaQuery.textScaleFactor.clamp(1.0, 1.15),
          ),
          child: AnimatedSwitcher(
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeIn,
            duration: const Duration(milliseconds: 300),
            child: handleStateView(),
          ));
    });
  }
}
