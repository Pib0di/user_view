part of 'app_cubit.dart';

enum WidgetStatus {
  loading,
  content,
  empty,
  error,
}

@immutable
class AppState {
  final WidgetStatus status;
  final ThemeMode themeMode;

  const AppState({
    this.themeMode = ThemeMode.light,
    this.status = WidgetStatus.content,
  });

  AppState copyWith({
    WidgetStatus? status,
    ThemeMode? themeMode,
  }) {
    return AppState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

final class AppInitial extends AppState {}
