import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_view/core/bloc/app_cubit.dart';

import '../../../../core/model/user_data.dart';
import '../../../../core/repository/content_repository.dart';
import '../../../../core/utils/tools/mixin.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with StartStopLoading {
  HomeCubit(this._contentRepository, this._appBloc) : super(HomeInitial());

  final ContentRepository _contentRepository;
  final AppCubit _appBloc;

  @override
  AppCubit get appBloc => _appBloc;

  Future<void> getUsers({bool? forceRefresh}) async {
    startLoading();

    final result = await _contentRepository.getUsers(extras: {'forceRefresh': forceRefresh});

    emit(state.copyWith(userData: result));

    stopLoading();
  }
}
