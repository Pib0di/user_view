part of 'home_cubit.dart';

@immutable
class HomeState {
  final List<UserData>? userData;

  const HomeState({
    this.userData,
  });

  HomeState copyWith({
    List<UserData>? userData,
  }) {
    return HomeState(
      userData: userData ?? this.userData,
    );
  }
}

final class HomeInitial extends HomeState {}
