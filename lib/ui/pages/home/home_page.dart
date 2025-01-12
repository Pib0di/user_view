import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_view/core/bloc/app_cubit.dart';
import 'package:user_view/ui/common/widgets/search.dart';
import 'package:user_view/ui/pages/home/bloc/home_cubit.dart';
import 'package:user_view/ui/pages/user/user_page.dart';

import '../../router/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit _homeCubit;
  late final AppCubit _appCubit;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    _homeCubit = context.read()..getUsers();
    _appCubit = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _appCubit.toggleTheme();
            }),
            icon: Icon(
              _appCubit.state.themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode_rounded,
            ),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            builder: (context, state) {
              if (appState.status == WidgetStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final searchQuery = textEditingController.text.toLowerCase();
              final filteredUsers = state.userData
                      ?.where((user) => user.name?.toLowerCase().contains(searchQuery) ?? false)
                      .toList() ??
                  [];

              return RefreshIndicator(
                  onRefresh: () => _homeCubit.getUsers(forceRefresh: true),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Search(
                          controller: textEditingController,
                          onChanged: (search) {
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 8),
                        filteredUsers.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('Empty'),
                                  IconButton(
                                    onPressed: () => _homeCubit.getUsers(forceRefresh: true),
                                    icon: Icon(Icons.refresh),
                                  )
                                ],
                              )
                            : Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: filteredUsers.length,
                                  itemBuilder: (_, index) {
                                    final data = filteredUsers[index];
                                    return ListTile(
                                      onTap: () => appRouter.pushClassNamed(UserPage, extra: data),
                                      title: Text('${data.name}'),
                                      subtitle: Text('${data.email}'),
                                      leading: Icon(Icons.person),
                                    );
                                  },
                                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                                ),
                              ),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
