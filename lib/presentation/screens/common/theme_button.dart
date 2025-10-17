import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injectable.dart';
import '../../../data/repositories/pref_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../theme/theme_data.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => ThemeButtonState();
}

class ThemeButtonState extends State<ThemeButton> {
  late ThemeBloc _themeBloc;
  late PrefRepository _prefRepo;

  late AppLocalizations l10n;
  String appTheme = '';

  @override
  void initState() {
    super.initState();
    _prefRepo = getIt<PrefRepository>();
    _themeBloc = context.read<ThemeBloc>();
    appTheme = AppTheme.currentTheme();
  }

  void onThemeChanged(ThemeMode themeMode) {
    _prefRepo.updateThemeMode(themeMode);
    _themeBloc.add(ThemeModeChanged(themeMode));
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return Tooltip(
      message: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
      child: IconButton(
        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        onPressed: () => {
          onThemeChanged(isDark ? ThemeMode.light : ThemeMode.dark),
        },
      ),
    );
  }
}
