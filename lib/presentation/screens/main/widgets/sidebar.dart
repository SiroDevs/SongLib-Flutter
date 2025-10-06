part of '../main_screen.dart';

class Sidebar extends StatelessWidget {
  final Function(PageType) onSelect;
  final PageType? pageType;

  const Sidebar({super.key, required this.pageType, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;

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
          isSelected: pageType == PageType.search,
          onPressed: () => onSelect(PageType.search),
        ),
        SidebarBtn(
          Icons.favorite,
          l10n.likesTitle,
          pageType: PageType.likes,
          isSelected: pageType == PageType.likes,
          onPressed: () => onSelect(PageType.likes),
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
          Icons.settings,
          l10n.settingsTitle,
          pageType: PageType.settings,
          isSelected: pageType == PageType.settings,
          onPressed: () => onSelect(PageType.settings),
        ),
      ],
    );

    return Scaffold(
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
            right: BorderSide(color: ThemeColors.foreColorPrimary1(context)),
          ),
        ),
        child: itemsColumn.padding(bottom: 20).constrained(maxWidth: 250),
      ),
    );
  }
}
