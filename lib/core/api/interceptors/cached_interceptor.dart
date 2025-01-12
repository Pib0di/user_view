import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../utils/logger.dart';

class CacheInterceptor extends Interceptor {
  final CacheManager cacheManager;

  CacheInterceptor()
      : cacheManager = CacheManager(
          Config(
            'dioCacheKey',
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 100,
            repo: JsonCacheInfoRepository(databaseName: 'my_cache'),
            fileService: HttpFileService(),
          ),
        );

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final forceRefresh = options.extra['forceRefresh'] == true;

      if (forceRefresh) {
        handler.next(options);
        return;
      }

      // check the cache
      // logger.i("Using cached data for ${options.uri}");
      final cachedFile = await cacheManager.getFileFromCache(options.uri.toString());

      if (cachedFile != null) {
        logger.i("Using cached data for ${options.uri}");
        final cachedData = await cachedFile.file.readAsBytes();

        try {
          final jsonString = utf8.decode(cachedData);
          final dynamic jsonData = json.decode(jsonString);

          // Returning cached data as a successful response
          handler.resolve(
            Response(
              requestOptions: options,
              statusCode: 200,
              data: jsonData,
            ),
          );
        } catch (e) {
          logger.e("Failed to parse cached data: $e");

          // If an error has occurred, we pass the request on.
          handler.next(options);
        }
        return;
      }
    } catch (e) {
      logger.e("Cache check failed: $e");
    }

    // If the data is not in the cache, we pass the request on.
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      // Сохраняем данные ответа в кэше
      if (response.statusCode == 200) {
        final uri = response.requestOptions.uri.toString();
        final data = response.data;

        // Преобразуем данные в байты
        Uint8List? bytes;
        if (data is String) {
          bytes = Uint8List.fromList(utf8.encode(data));
        } else if (data is List<int>) {
          bytes = Uint8List.fromList(data);
        } else if (data is Map || data is List) {
          // Преобразуем Map или List в строку, затем в байты
          final jsonString = json.encode(data);
          bytes = Uint8List.fromList(utf8.encode(jsonString));
        } else {
          bytes = Uint8List.fromList(utf8.encode(data.toString()));
        }

        await cacheManager.putFile(uri, bytes);
      }
    } catch (e) {
      logger.e("Failed to cache response: $e");
    }

    handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.unknown || err.type == DioExceptionType.connectionTimeout) {
      try {
        final cachedFile = await cacheManager.getFileFromCache(err.requestOptions.uri.toString());

        if (cachedFile != null) {
          print("Using cached data on error for ${err.requestOptions.uri}");
          final cachedData = await cachedFile.file.readAsBytes();

          // Возвращаем кэшированные данные как успешный ответ
          handler.resolve(Response(
            requestOptions: err.requestOptions,
            statusCode: 200,
            data: cachedData,
          ));
          return;
        }
      } catch (e) {
        print("Cache fallback failed: $e");
      }
    }

    // Если данных нет в кэше, передаем ошибку дальше
    handler.next(err);
  }
}
