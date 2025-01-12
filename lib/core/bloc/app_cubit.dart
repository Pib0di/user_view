import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  void setLoadingStatus(WidgetStatus status) {
    emit(state.copyWith(status: status));
  }

  void toggleTheme() {
    ThemeMode themeMode = state.themeMode;
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: themeMode));
  }
}
