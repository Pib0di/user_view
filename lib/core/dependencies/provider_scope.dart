import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_view/core/api/interceptors/cached_interceptor.dart';
import 'package:user_view/core/bloc/app_cubit.dart';
import 'package:user_view/ui/pages/home/bloc/home_cubit.dart';

import '../api/dio_factory.dart';
import '../api/rest_api/public_client.dart';
import '../repository/content_repository.dart';

class ProviderScope extends StatefulWidget {
  const ProviderScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ProviderScope> createState() => _ProviderScopeState();
}

class _ProviderScopeState extends State<ProviderScope> {
  late final PublicClient _publicClient;

  late final ContentRepository _contentRepository;

  late final AppCubit _appBloc;
  late final HomeCubit _homeBloc;

  Dio publicDio = DioFactory.newInstance();

  @override
  void initState() {
    // api client
    _publicClient = PublicClient(publicDio);

    // repository
    _contentRepository = ContentRepository(_publicClient);

    //bloc
    _appBloc = AppCubit();
    _homeBloc = HomeCubit(_contentRepository, _appBloc);

    //add interceptor
    // publicDio.interceptors.add(ServerErrorInterceptor());
    publicDio.interceptors.add(CacheInterceptor());

    // utils
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _contentRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _appBloc, lazy: false),
          BlocProvider(create: (_) => _homeBloc, lazy: false),
        ],
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _appBloc.close();
    super.dispose();
  }
}
