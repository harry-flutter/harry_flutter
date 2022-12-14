import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/bloc/harry_collections_bloc.dart';
import '../application/bloc/user_auth_bloc.dart';
import '../application/injection_module/injection_container.dart';
import '../application/navigation/app_router.gr.dart';
import 'application/theme/app_theme.dart';
import 'data/repositories/settings_repository.dart';
import 'ui/routes/login_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = sl<AppRouter>();

  final settingsRepository = sl<SettingsRepository>();

  @override
  Widget build(BuildContext context) {
    final harryCollectionsBloc = HarryCollectionsBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAuthBloc>(
          create: (BuildContext context) => UserAuthBloc(
            settingsRepository: settingsRepository,
          ),
        ),
        BlocProvider<HarryCollectionsBloc>(
          create: (BuildContext context) => harryCollectionsBloc,
        ),
      ],
      child: MaterialApp.router(
        title: 'Harry Flutter',
        theme: AppTheme.lightTheme(),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return BlocBuilder<UserAuthBloc, UserAuthState>(
            builder: (context, state) {
              harryCollectionsBloc.add(const HarryCollectionsEvent.init());
              return state.maybeMap(orElse: () {
                return Overlay(
                  initialEntries: [
                    OverlayEntry(
                      builder: (context) => const LoginPage(),
                    ),
                  ],
                );
              }, authorized: (login) {
                return child ?? const SizedBox.shrink();
              });
            },
          );
        },
      ),
    );
  }
}
