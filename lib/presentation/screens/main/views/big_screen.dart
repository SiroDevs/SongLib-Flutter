part of '../main_screen.dart';

class BigScreen extends StatefulWidget {
  final HomeScreenState parent;
  const BigScreen({super.key, required this.parent});

  @override
  State<BigScreen> createState() => BigScreenState();
}

class BigScreenState extends State<BigScreen> {
  late HomeScreenState parent;
  late AppLocalizations l10n;
  bool isSearchPage = false;
  late SongExt selectedSong;

  void setCurrentPage(PageType page) {
    setState(() => parent.currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    parent = widget.parent;
    l10n = AppLocalizations.of(context)!;
    isSearchPage =
        parent.currentPage == PageType.search || parent.currentPage == PageType.likes;

    return Stack(
      children: [
        FadingIndexedStack(
          duration: AppDurations.slow,
          index: pages.indexOf(parent.currentPage),
          children: <Widget>[
            //ListTabPc(vm),
            SongsScreen(parent: parent, isBigScreen: true),
            LikesScreen(books: parent.books),
            //DraftsTabPc(vm),
            //const HelpDeskScreen(),
            const SettingsScreen(),
          ],
        )
            .positioned(left: 250, right: 0, bottom: 0, top: 0, animate: true)
            .animate(.35.seconds, Curves.bounceIn),
        Sidebar(
          pageType: parent.currentPage,
          onSelect: (page) => setCurrentPage(page),
        )
            .positioned(left: 0, top: 0, bottom: 0, width: 250, animate: true)
            .animate(.35.seconds, Curves.easeOut),
      ],
    );
  }
}
