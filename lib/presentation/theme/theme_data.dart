import 'package:flutter/material.dart';

import '../../core/utils/constants/app_constants.dart';
import '../../data/repositories/pref_repository.dart';
import '../../core/utils/app_util.dart';
import '../../core/di/injectable.dart';
import 'theme_colors.dart';

class AppTheme {
  AppTheme._();

  static String currentTheme() {
    var prefRepo = getIt<PrefRepository>();
    return getThemeModeString(prefRepo.getThemeMode());
  }

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ThemeColors.lightGray,
      fontFamily: AppConstants.kFontFamily,
      colorScheme: const ColorScheme.light(
        primary: ThemeColors.primary,
        onPrimary: Colors.white,
        primaryContainer: ThemeColors.primary,
        secondary: ThemeColors.primary1,
        onSecondary: Colors.white,
        secondaryContainer: ThemeColors.accent1,
        tertiary: ThemeColors.accent2,
        onTertiary: Colors.white,
        tertiaryContainer: ThemeColors.accent3,
        surface: Colors.white,
        onSurface: Colors.black,
        surfaceVariant: ThemeColors.backgroundGrey,
        onSurfaceVariant: ThemeColors.mediumGrey,
        background: ThemeColors.lightGray,
        onBackground: Colors.black,
        error: ThemeColors.error,
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        outline: ThemeColors.primary,
        outlineVariant: ThemeColors.lightGrey,
        shadow: ThemeColors.shadow,
        surfaceTint: ThemeColors.primary,
        inverseSurface: Colors.black,
        onInverseSurface: Colors.white,
        inversePrimary: ThemeColors.primaryDark2,
        scrim: Color(0x52000000),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: ThemeColors.accent,
        elevation: 3,
        iconTheme: MaterialStateProperty.all(const IconThemeData(color: ThemeColors.primary)),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(color: ThemeColors.primary, fontFamily: AppConstants.kFontFamily),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      fontFamily: AppConstants.kFontFamily,
      colorScheme: const ColorScheme.dark(
        primary: ThemeColors.primary2,
        onPrimary: ThemeColors.primaryDark1,
        primaryContainer: ThemeColors.primaryDark,
        secondary: ThemeColors.accent1,
        onSecondary: ThemeColors.primaryDark1,
        secondaryContainer: ThemeColors.primaryDark2,
        tertiary: ThemeColors.accent3,
        onTertiary: Colors.black,
        tertiaryContainer: ThemeColors.primary3,
        surface: ThemeColors.primaryDark,
        onSurface: Colors.white,
        surfaceVariant: ThemeColors.primaryDark1,
        onSurfaceVariant: ThemeColors.accent1,
        background: ThemeColors.primaryDark2,
        onBackground: Colors.white,
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        outline: ThemeColors.primaryDark1,
        outlineVariant: ThemeColors.primaryDark,
        shadow: Colors.black,
        surfaceTint: ThemeColors.primary2,
        inverseSurface: Colors.white,
        onInverseSurface: ThemeColors.primaryDark1,
        inversePrimary: ThemeColors.accent1,
        scrim: Color(0x52000000),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ThemeColors.primaryDark2,
        foregroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ThemeColors.primaryDark,
        indicatorColor: ThemeColors.accent,
        elevation: 3,
        iconTheme: MaterialStateProperty.all(const IconThemeData(color: Colors.white)),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white, fontFamily: AppConstants.kFontFamily),
        ),
      ),
      cardTheme: CardThemeData(
        color: ThemeColors.primaryDark1,
        surfaceTintColor: ThemeColors.primaryDark1,
        shadowColor: ThemeColors.primaryDark,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ThemeColors.primaryDark,
        surfaceTintColor: ThemeColors.primaryDark,
      ),
    );
  }  
}