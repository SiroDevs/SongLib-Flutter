import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../data/models/models.dart';
import '../../../core/utils/app_util.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/list_items/search_book_item.dart';
import '../../widgets/list_items/search_song_item.dart';
import '../../theme/theme_styles.dart';
import '../../blocs/home/home_bloc.dart';
import '../common/app_intents.dart';
import '../common/search_songs_utils.dart';
import '../home/home_screen.dart';
import '../presentor/ui/presentor_screen.dart';

part 'widgets/song_viewer.dart';
part 'widgets/list_widgets.dart';

class SongsScreen extends StatefulWidget {
  final bool isBigScreen;
  final HomeScreenState parent;

  const SongsScreen({
    super.key,
    required this.parent,
    this.isBigScreen = false,
  });

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  late HomeBloc bloc;
  late HomeScreenState parent;
  late FocusNode searchFocus;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    parent = widget.parent;
    bloc = context.read<HomeBloc>();
    searchFocus = FocusNode();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchFocus.dispose();
    searchController.dispose();

    super.dispose();
  }

  Future<void> onSongSelect(SongExt song, bool shouldOpen) async {
    setState(() => parent.selectedSong = song);
    if (shouldOpen) {
      onSongOpen();
    }
  }

  Future<void> onSongOpen() async {
    SongExt song = parent.selectedSong;
    Book book = parent.books[0];
    try {
      parent.books.firstWhere(
        (b) => b.bookId == song.book,
        orElse: () => parent.books[0],
      );
    } catch (e) {
      logger('Failed to get the book: $e');
    }

    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PresentorScreen(
          song: song,
          book: book,
          songs: parent.songs,
        ),
      ),
    );

    if (result == true) {
      bloc.add(FilterData(book));
    }
  }

  void _onSearch(String query) {
    setState(() {
      parent.filtered = query.isEmpty
          ? parent.songs
          : filterSongsByQuery(query.toLowerCase(), parent.songs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isBigScreen
        ? _buildBigScreen()
        : SingleChildScrollView(
            child: Column(
              children: [
                BooksList(books: parent.books, selectedBook: 0),
                SongsList(
                  selectedSong: parent.selectedSong,
                  songs: parent.filtered,
                  onTap: onSongSelect,
                ),
              ],
            ),
          );
  }

  Widget _buildBigScreen() {
    return LayoutBuilder(builder: (context, dimens) {
      var bigScreenView = Row(
        children: [
          Scaffold(
            appBar: AppBar(
              title: SearchWidget(
                searchFocus: searchFocus,
                searchController: searchController,
                onSearch: _onSearch,
              ),
            ),
            body: Column(
              children: [
                BooksList(
                  books: parent.books,
                  selectedBook: parent.selectedBook,
                ),
                SongsList(
                  selectedSong: parent.selectedSong,
                  songs: parent.filtered,
                  onTap: onSongSelect,
                  isBigScreen: true,
                ).expanded(),
              ],
            ),
          ).width(dimens.maxWidth / 2.2),
          SongViewer(
            song: parent.selectedSong,
            books: parent.books,
            songs: parent.songs,
          ).expanded(),
        ],
      );
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        return Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            CharacterActivator('s'): SearchIntent(),
            SingleActivator(LogicalKeyboardKey.enter): OpenIntent(),
            SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              SearchIntent: CallbackAction<SearchIntent>(
                onInvoke: (intent) => searchFocus.requestFocus(),
              ),
              OpenIntent: CallbackAction<OpenIntent>(
                onInvoke: (intent) => onSongOpen(),
              ),
            },
            child: Focus(
              autofocus: true,
              onKeyEvent: (node, event) {
                logger('Key pressed: ${event.logicalKey.keyLabel}');
                return KeyEventResult.ignored;
              },
              child: bigScreenView,
            ),
          ),
        );
      } else {
        return bigScreenView;
      }
    });
  }
}
