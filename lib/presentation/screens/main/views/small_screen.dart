part of '../main_screen.dart';

class SmallScreen extends StatefulWidget {
  final HomeScreenState parent;
  const SmallScreen({super.key, required this.parent});

  @override
  State<SmallScreen> createState() => SmallScreenState();
}

class SmallScreenState extends State<SmallScreen> {
  late HomeScreenState parent;
  late AppLocalizations l10n;

  void onPageChanged(int index) {
    setState(() {
      parent.selectedPage = index;
      parent.pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    parent = widget.parent;
    l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    List<PageItem> homeScreens = [
      PageItem(
        title: 'Songs',
        icon: Icons.search,
        screen: SongsScreen(parent: parent),
      ),
      PageItem(
        title: 'Likes',
        icon: Icons.favorite,
        screen: LikesScreen(books: parent.books),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: [
          if (parent.selectedPage == 0) ...[
            IconButton(
              icon: Platform.isIOS
                  ? Icon(CupertinoIcons.search)
                  : Icon(Icons.search),
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: SongsSearch(
                    context,
                    parent.books,
                    parent.songs,
                    size.height * 0.5,
                  ),
                );
              },
            ),
          ],
          IconButton(
            icon: Platform.isIOS
                ? Icon(CupertinoIcons.settings)
                : Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.settings);
            },
          ),
        ],
      ),
      body: PageView(
        controller: parent.pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreens.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: parent.selectedPage,
        onPageChange: onPageChanged,
        pages: homeScreens,
      ),
    );
  }
}
