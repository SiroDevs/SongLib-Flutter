part of '../main_screen.dart';

class Sidebar extends StatefulWidget {
  final Function(PageType) onSelect;
  final PageType? pageType;

  const Sidebar({super.key, required this.pageType, required this.onSelect});

  @override
  State<Sidebar> createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
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
    var l10n = AppLocalizations.of(context)!;
    var isDark = Theme.of(context).brightness == Brightness.dark;

    var itemsColumn = Column(
      children: <Widget>[
        /*SidebarBtn(
          Icons.list,
          l10n.listTitle,
          pageType: PageType.lists,
          isSelected: pageType == PageType.lists,
          onPressed: () => onSelect(PageType.lists),
        ),*/
        SidebarBtn(
          Icons.search,
          l10n.searchTitle,
          pageType: PageType.search,
          isSelected: widget.pageType == PageType.search,
          onPressed: () => widget.onSelect(PageType.search),
        ),
        SidebarBtn(
          Icons.favorite,
          l10n.likesTitle,
          pageType: PageType.likes,
          isSelected: widget.pageType == PageType.likes,
          onPressed: () => widget.onSelect(PageType.likes),
        ),
        /*SidebarBtn(
          Icons.edit,
          l10n.draftTitle,
          pageType: PageType.drafts,
          isSelected: pageType == PageType.drafts,
          onPressed: () => onSelect(PageType.drafts),
        ),
        const Divider(color: ThemeColors.primaryDark),*/
        const Spacer(),
        const Divider(color: ThemeColors.primaryDark, height: 1),
        /*SidebarBtn(
          Icons.support,
          l10n.helpdeskTitle,
          pageType: PageType.helpdesk,
          isSelected: pageType == PageType.helpdesk,
          onPressed: () => onSelect(PageType.helpdesk),
        ),
        const Divider(color: ThemeColors.primaryDark),*/
        SidebarBtn(
          isDark ? Icons.light_mode : Icons.dark_mode,
          isDark ? "LIGHT MODE" : "DARK MODE",
          onPressed: () => {
            onThemeChanged(isDark ? ThemeMode.light : ThemeMode.dark),
          },
        ),
        const Divider(color: ThemeColors.primaryDark, height: 1),
        SidebarBtn(
          Icons.settings,
          l10n.settingsTitle,
          pageType: PageType.settings,
          isSelected: widget.pageType == PageType.settings,
          onPressed: () => widget.onSelect(PageType.settings),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset(AppAssets.iconApp),
        ),
        title: Text(l10n.appName, style: TextStyle(fontSize: 25)),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
              width: 1,
            ),
          ),
        ),
        child: itemsColumn.padding(bottom: 20).constrained(maxWidth: 250),
      ),
    );
  }
}
