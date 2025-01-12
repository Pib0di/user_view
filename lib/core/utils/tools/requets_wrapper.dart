import 'package:dio/dio.dart';
import 'package:user_view/ui/common/action/toasts.dart';

import '../logger.dart';

Future<T?> appToastWrapper<T>(Future<T> Function() requestFunction) async {
  try {
    return await requestFunction();
  } on DioException catch (ex) {
    final messageError = ex.response?.data;
    logger.e('DioException=> $messageError');

    AppToast.error(messageError ?? 'Error occurred');
  } catch (ex, stackTrace) {
    logger.e('appToastWrapper=> $ex', stackTrace: stackTrace);
    AppToast.error('Unexpected error');
  }
  return null;
}
