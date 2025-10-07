import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/utils/app_util.dart';
import '../../../core/di/injectable.dart';
import '../../../core/utils/constants/pref_constants.dart';
import '../../../data/repositories/database_repository.dart';
import '../../../data/repositories/pref_repository.dart';
import '../../l10n/app_localizations.dart';
import '../../navigator/route_names.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme_data.dart';
import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';
import '../../widgets/inputs/radio_input.dart';
import '../../widgets/progress/custom_snackbar.dart';

part 'settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late PrefRepository _prefRepo;
  late DatabaseRepository _dbRepo;

  bool updateFound = false, slideVertical = true;
  late AppLocalizations l10n;

  @override
  void initState() {
    super.initState();
    _prefRepo = getIt<PrefRepository>();
    _dbRepo = getIt<DatabaseRepository>();
    slideVertical = _prefRepo.getPrefBool(PrefConstants.slideVerticalKey);
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    final items = [
      SettingCard(title: l10n.displayTitle, widgets: [SettingsThemeItem()]),
      SettingCard(
        title: l10n.collectionTitle,
        widgets: [
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text(l10n.reselectSongbooks),
            subtitle: Text(l10n.reselectSongbooksDesc),
            onTap: onResetData,
          ),
        ],
      ),
      SettingCard(
        title: l10n.presentationTitle,
        widgets: [
          ListTile(
            leading: Icon(Icons.slideshow),
            title: Text(l10n.songPresentation),
            subtitle: Text(l10n.songPresentationDesc),
            trailing: Switch(
              value: slideVertical,
              onChanged: (value) => updateSlideAxis(value),
            ),
            onTap: () => updateSlideAxis(!slideVertical),
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appSettings)),
      body: LayoutBuilder(
        builder: (context, dimens) {
          final axisCount = (dimens.maxWidth / 500).round();
          return GridView.builder(
            padding: const EdgeInsets.all(Sizes.sm),
            physics: const ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisCount,
              childAspectRatio: 4,
            ),
            itemCount: items.length,
            itemBuilder: (_, index) => items[index],
          );
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
        RouteNames.step1,
        (route) => false,
      );
    } catch (e) {
      logger('Unable to: $e');
    }
  }
}
