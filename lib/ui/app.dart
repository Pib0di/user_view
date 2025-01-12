import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_view/core/bloc/app_cubit.dart';
import 'package:user_view/ui/common/app_theme/theme.dart';
import 'package:user_view/ui/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          routerConfig: appRouter,
          title: 'Flutter Demo',
          theme: makeAppTheme(),
          darkTheme: makeAppTheme(isDark: true),
        );
      },
    );
  }
}
