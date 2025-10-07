part of 'settings_screen.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final List<Widget> widgets;

  const SettingCard({super.key, required this.title, required this.widgets});

  @override
  Widget build(BuildContext context) {
    final items = [
      Text(
        title,
        style: TextStyles.headingStyle3,
      ).padding(left: Sizes.sm, top: Sizes.sm),
    ];
    for (var widget in widgets) {
      items.add(Card(child: widget));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: items,
    );
  }
}

class SettingsThemeItem extends StatefulWidget {
  const SettingsThemeItem({super.key});

  @override
  State<SettingsThemeItem> createState() => SettingsThemeItemState();
}

class SettingsThemeItemState extends State<SettingsThemeItem> {
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

    return ListTile(
      leading: Icon(Icons.color_lens),
      title: Text(l10n.appTheme),
      subtitle: Text('${l10n.appThemeDesc} $appTheme'),
      onTap: () => selectThemeDialog(context),
    );
  }

  Future<void> selectThemeDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set the Theme'),
          content: SizedBox(
            height: 135,
            child: RadioInput(
              initValue: appTheme,
              options: const ['System Theme', 'Light Theme', 'Dark Theme'],
              vertical: true,
              onChanged: (String? newValue) {
                setState(() {
                  switch (newValue) {
                    case 'Light Theme':
                      onThemeChanged(ThemeMode.light);
                      break;
                    case 'Dark Theme':
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
