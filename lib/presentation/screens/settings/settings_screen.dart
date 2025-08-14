import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/utils/app_util.dart';
import '../../../data/repositories/database_repository.dart';
import '../../../data/repositories/pref_repository.dart';
import '../../../core/utils/constants/pref_constants.dart';
import '../../widgets/inputs/radio_input.dart';
import '../../widgets/progress/custom_snackbar.dart';
import '../../../core/di/injectable.dart';
import '../../navigator/route_names.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme_data.dart';
import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late ThemeBloc _themeBloc;
  late PrefRepository _prefRepo;
  late DatabaseRepository _dbRepo;

  bool updateFound = false, slideVertical = true;
  late AppLocalizations l10n;
  String appTheme = '';

  @override
  void initState() {
    super.initState();
    _prefRepo = getIt<PrefRepository>();
    _dbRepo = getIt<DatabaseRepository>();
    _themeBloc = context.read<ThemeBloc>();
    appTheme = AppTheme.currentTheme();
    slideVertical = _prefRepo.getPrefBool(PrefConstants.slideVerticalKey);
  }

  void onThemeChanged(ThemeMode themeMode) {
    _prefRepo.updateThemeMode(themeMode);
    _themeBloc.add(ThemeModeChanged(themeMode));
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    var widgets = [
      Text(
        l10n.displayTitle,
        style: TextStyles.headingStyle3,
      ).padding(left: Sizes.sm, top: Sizes.sm),
      Card(
        child: ListTile(
          leading: Icon(Icons.color_lens),
          title: Text(l10n.appTheme),
          subtitle: Text('${l10n.appThemeDesc} $appTheme'),
          onTap: () => selectThemeDialog(context),
        ),
      ),
      Text(
        l10n.collectionTitle,
        style: TextStyles.headingStyle3,
      ).padding(left: Sizes.sm, top: Sizes.sm),
      Card(
        child: ListTile(
          leading: Icon(Icons.library_books),
          title: Text(l10n.reselectSongbooks),
          subtitle: Text(l10n.reselectSongbooksDesc),
          onTap: onResetData,
        ),
      ),
      Text(
        l10n.presentationTitle,
        style: TextStyles.headingStyle3,
      ).padding(left: Sizes.sm, top: Sizes.sm),
      Card(
        child: ListTile(
          leading: Icon(Icons.slideshow),
          title: Text(l10n.songPresentation),
          subtitle: Text(l10n.songPresentationDesc),
          trailing: Switch(
            value: slideVertical,
            onChanged: (value) => updateSlideAxis(value),
          ),
          onTap: () => updateSlideAxis(!slideVertical),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appSettings)),
      body: ListView.separated(
        itemCount: widgets.length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: Sizes.xs),
        padding: const EdgeInsets.all(Sizes.sm),
        itemBuilder: (context, index) {
          return widgets[index];
        },
      ),
    );
  }

  Future<void> updateSlideAxis(bool value) async {
    _prefRepo.setPrefBool(PrefConstants.slideVerticalKey, value);
    setState(() => slideVertical = value);
  }

  Future<void> onResetData() async {
    try {
      await _dbRepo.removeAllBooks();
      await _dbRepo.removeAllSongs();
      _prefRepo.clearData();
      CustomSnackbar.show(context, l10n.redirectingYou);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.step1Selection,
        (route) => false,
      );
    } catch (e) {
      logger('Unable to: $e');
    }
  }

  Future<void> selectThemeDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Theme'),
          content: SizedBox(
            height: 135,
            child: RadioInput(
              initValue: appTheme,
              options: const ['System Theme', 'Light', 'Dark'],
              vertical: true,
              onChanged: (String? newValue) {
                setState(() {
                  switch (newValue) {
                    case 'Light':
                      onThemeChanged(ThemeMode.light);
                      break;
                    case 'Dark':
                      onThemeChanged(ThemeMode.dark);
                      break;
                    default:
                      onThemeChanged(ThemeMode.system);
                      break;
                  }
                  appTheme = AppTheme.currentTheme();
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        );
      },
    );
  }
}
