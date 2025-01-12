import 'package:dio/dio.dart';
import 'package:user_view/core/utils/logger.dart';

class AccessTokenNotFoundException implements Exception {}

class RefreshTokenNotFoundException implements Exception {}

class ServerErrorInterceptor extends Interceptor {
  final Dio dio;

  ServerErrorInterceptor(this.dio);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // AppToast.error('${err.message}');
    logger.e('onError=>${err.message}');
  }
}
