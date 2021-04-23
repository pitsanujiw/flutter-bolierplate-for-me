import 'package:flutter/foundation.dart';

Environment env = kReleaseMode
    ? Environment.production()
    : kProfileMode
        ? Environment.staging()
        : Environment.development();

enum EnvironmentMode {
  production,
  staging,
  development,
}

class Environment {
  EnvironmentMode _mode;
  final String localStorageKey = "@carmana_";
  final String appKey = 'base64:uvaL3KE+uQD1vGxYm5kWs01BQH3VNwNqeF1qY5rrTnI=';
  String _apiUrl = "";
  String get apiUrl => _apiUrl;
  Environment.development() {
    _apiUrl = "";
    this._mode = EnvironmentMode.development;
  }

  Environment.staging() {
    _apiUrl = "";
    this._mode = EnvironmentMode.staging;
  }

  Environment.production() {
    _apiUrl = "";
    this._mode = EnvironmentMode.production;
  }

  bool get isProduction => _mode == EnvironmentMode.production;

  bool get isStaging => _mode == EnvironmentMode.staging;

  bool get isDevelopment => _mode == EnvironmentMode.development;

  @override
  String toString() {
    if (isProduction) return "production";
    if (isStaging) return "staging";
    return "development";
  }
}
