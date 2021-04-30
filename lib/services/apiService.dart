import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bolierplate_example/global/global.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';

// 200 // success
// 201 // created
// 203 // updated
// 400 // error / bad request
// 401 // unauthenticated
// 403 // forbidden
// 404 // not found
// 405 // wrong request method
// 500 // internal server error

enum ResponseStatus {
  clientError,
  serverError,
  networkError,
  success,
}

class ApiService {
  // states
  Dio _dio = Dio();
  BaseOptions _baseOptions = BaseOptions(
    baseUrl: "${env.apiUrl}/api",
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
    headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": env.appKey
    },
  );

  late String _token;
  String get token => _token;

  // constructor
  ApiService() {
    _dio.options = _baseOptions;
  }

  // methods
  void setToken(String token) {
    _dio.options.headers["token"] = "${token.toString()}";
    _token = token;
  }

  void setLanguageCode(String languageCode) {
    _dio.options.headers["Accept-Language"] = languageCode.toString();
  }

  ApiResponse _handleResponse(Response response) {
    if (!(response.data is Map<String, dynamic>)) {
      Log.wtf(
        {
          "method": response.requestOptions.method,
          "status_code": response.statusCode,
          "path": response.requestOptions.path,
          "data": response.requestOptions.data,
          "queryParameters": response.requestOptions.queryParameters,
          "message": response.data,
          "headers": response.requestOptions.headers,
        },
      );

      return ApiResponse.fromStatusCode(
        statusCode: response.statusCode ?? 500,
      );
    }

    return ApiResponse.fromJson(response.data);
  }

  ApiResponse _handleDioError(DioError error, StackTrace trace) {
    dynamic data = {};

    if (error.requestOptions.data is FormData) {
      data = error.requestOptions.data.toString();
    } else {
      data = error.requestOptions.data;
    }

    Map<String, dynamic> params = {
      "method": error.requestOptions.method,
      "status_code": error.response!.statusCode,
      "path": error.requestOptions.path,
      "data": data,
      "queryParameters": error.requestOptions.queryParameters,
      "message": error.requestOptions.data ?? error.message,
      "headers": error.requestOptions.headers,
    };

    Log.error(
      params,
      exception: error.error,
      stackTrace: trace,
    );

    // String errorMessage = error?.message;

    // if (error?.response?.data is Map<String, dynamic> &&
    //     error.response.data.containsKey("message")) {
    //   errorMessage = error.response.data["message"].toString();
    // }

    switch (error.type) {
      case DioErrorType.connectTimeout:
        return ApiResponse.networkError();

      case DioErrorType.sendTimeout:
        return ApiResponse.networkError();

      case DioErrorType.receiveTimeout:
        return ApiResponse.networkError();

      default:
        if (error.error is SocketException) {
          return ApiResponse.networkError();
        }
    }

    return ApiResponse.fromStatusCode(
      statusCode: error.response!.statusCode!,
    );
  }

  // ####################################################################################

  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      path = path[0] == "/" ? path : "/$path";

      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ..._baseOptions.headers,
            ...headers,
          },
        ),
      );

      return _handleResponse(response);
    } on DioError catch (error, trace) {
      return _handleDioError(error, trace);
    }
  }

  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
    Function(int, int)? onSendProgress,
  }) async {
    try {
      path = path[0] == "/" ? path : "/$path";

      Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress ?? (sent, total) {},
        options: Options(
          headers: {
            ..._baseOptions.headers,
            ...headers,
          },
        ),
      );

      return _handleResponse(response);
    } on DioError catch (error, trace) {
      return _handleDioError(error, trace);
    }
  }

  Future<ApiResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      path = path[0] == "/" ? path : "/$path";

      Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ..._baseOptions.headers,
            ...headers,
          },
        ),
      );

      return _handleResponse(response);
    } on DioError catch (error, trace) {
      return _handleDioError(error, trace);
    }
  }

  Future<ApiResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      path = path[0] == "/" ? path : "/$path";

      Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ..._baseOptions.headers,
            ...headers,
          },
        ),
      );

      return _handleResponse(response);
    } on DioError catch (error, trace) {
      return _handleDioError(error, trace);
    }
  }

  Future<ApiResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> headers = const {},
  }) async {
    try {
      path = path[0] == "/" ? path : "/$path";

      Response response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ..._baseOptions.headers,
            ...headers,
          },
        ),
      );

      return _handleResponse(response);
    } on DioError catch (error, trace) {
      return _handleDioError(error, trace);
    }
  }
}

class ApiResponse {
  final ResponseStatus? status;
  final dynamic message;
  final dynamic data;
  final int? code;

  ApiResponse({
    this.status,
    this.data,
    this.message,
    this.code,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return ApiResponse(
      status: ResponseStatus.success,
      code: json["code"] ?? 200,
      message: json["message"] ?? "",
      data: json["data"] ?? [],
    );
  }

  factory ApiResponse.fromStatusCode({
    required int statusCode,
  }) {
    if (statusCode >= 400 && statusCode <= 499) {
      return ApiResponse(
        status: ResponseStatus.clientError,
        code: statusCode,
      );
    } else if (statusCode >= 500 && statusCode <= 599) {
      return ApiResponse(
        status: ResponseStatus.serverError,
        code: statusCode,
      );
    } else {
      return ApiResponse(
        status: ResponseStatus.success,
        code: statusCode,
      );
    }
  }

  factory ApiResponse.networkError() {
    return ApiResponse(
      status: ResponseStatus.networkError,
      code: 200,
    );
  }

  bool get hasError {
    return this.status != ResponseStatus.success;
  }

  Map<String, dynamic> toJson() {
    return {
      "status": this.status.toString(),
      "code": this.code,
      "message": this.message,
      "data": this.data,
    };
  }
}
