import 'package:user_view/core/bloc/app_cubit.dart';

mixin StartStopLoading {
  AppCubit get appBloc;

  void startLoading() {
    appBloc.setLoadingStatus(WidgetStatus.loading);
  }

  void stopLoading() {
    appBloc.setLoadingStatus(WidgetStatus.content);
  }
}
