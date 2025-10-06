import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/auth/auth_bloc.dart';
import 'core/di/injectable.dart';
import 'data/sources/remote/api_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/pref_repository.dart';
import 'core/utils/constants/pref_constants.dart';
import 'domain/repositories/sync_repository.dart';
import 'presentation/l10n/app_localizations.dart';
import 'presentation/navigator/main_navigator.dart';
import 'presentation/navigator/route_names.dart';
import 'presentation/theme/bloc/theme_bloc.dart';
import 'presentation/theme/theme_data.dart';

class MyApp extends StatefulWidget {
  final Widget? home;
  const MyApp({super.key, this.home});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;
  late final AuthRepository _authRepo;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepository();
  }

  @override
  void dispose() {
    _authRepo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AuthBloc(authRepo: _authRepo),
        child: const AppView(),
      ),
    );
  }
}

/// A widget that builds the main view of the application. It sets up the
/// necessary providers and handles navigation and theming.
///
/// The [AppView] widget can optionally take a [home] widget to display as the
/// initial screen.
class AppView extends StatefulWidget {
  final Widget? home;
  const AppView({super.key, this.home});

  @override
  State<AppView> createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final navigatorKey = MainNavigatorState.navigationKey;
  NavigatorState get navigator =>
      MainNavigatorState.navigationKey.currentState!;
  final _syncRepo = SyncRepository();
  final _prefrepo = getIt<PrefRepository>();

  @override
  Widget build(BuildContext context) {
    bool isSelected = _prefrepo.getPrefBool(PrefConstants.dataIsSelectedKey);
    bool isLoaded = _prefrepo.getPrefBool(PrefConstants.dataIsLoadedKey);

    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            home: widget.home,
            themeMode: _prefrepo.getThemeMode(),
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            supportedLocales: const [Locale('en'), Locale('sw')],
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: MainNavigatorState.initialRoute,
            onGenerateRoute: MainNavigatorState.onGenerateRoute,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (isLoaded) {
                  if (await isConnectedToInternet()) {
                    await _syncRepo.syncData();
                  }
                  navigator.pushNamedAndRemoveUntil<void>(
                    RouteNames.main,
                    (route) => false,
                  );
                } else {
                  if (isSelected) {
                    navigator.pushNamedAndRemoveUntil<void>(
                      RouteNames.step2Selection,
                      (route) => false,
                    );
                  } else {
                    navigator.pushNamedAndRemoveUntil<void>(
                      RouteNames.step1Selection,
                      (route) => false,
                    );
                  }
                }
              },
              child: child,
            ),
          );
        },
      ),
    );
  }
}
