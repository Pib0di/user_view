import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:user_view/core/utils/constants/endpoints.dart';

const timeoutTimeMilliseconds = 30 * 1000;

class DioFactory {
  static Dio newInstance() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: timeoutTimeMilliseconds),
        receiveTimeout: const Duration(milliseconds: timeoutTimeMilliseconds),
        sendTimeout: const Duration(milliseconds: timeoutTimeMilliseconds),
        receiveDataWhenStatusError: true,
      ),
    );

    dio.options.baseUrl = ApiEndpoints.baseUrl;

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }
}
