part of '../songs_screen.dart';

class SongViewer extends StatefulWidget {
  final SongExt song;
  final List<Book> books;
  final List<SongExt> songs;
  const SongViewer({
    super.key,
    required this.song,
    required this.books,
    required this.songs,
  });

  @override
  State<SongViewer> createState() => SongViewerState();
}

class SongViewerState extends State<SongViewer> {
  late MainBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<MainBloc>();
  }

  Future<void> onPresent() async {
    Book book = widget.books[0];
    try {
      widget.books.firstWhere(
        (b) => b.bookId == widget.song.book,
        orElse: () => widget.books[0],
      );
    } catch (e) {
      logger('Failed to get the book: $e');
    }

    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PresentorScreen(
          song: widget.song,
          book: book,
          songs: widget.songs,
        ),
      ),
    );

    if (result == true) {
      bloc.add(FilterData(book));
    }
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    List<String> verses = widget.song.content.split("##");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${songItemTitle(widget.song.songNo, widget.song.title)} - ${refineTitle(widget.song.songbook)}',
        ),
        actions: <Widget>[
          Tooltip(
            message: l10n.copySong,
            child: InkWell(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.copy),
              ),
            ),
          ),
          Tooltip(
            message: widget.song.liked ? l10n.songDislike : l10n.songLike,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  widget.song.liked ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ),
          ),
          Tooltip(
            message: l10n.projectSong,
            child: InkWell(
              onTap: onPresent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.north_east),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              verses[index].replaceAll("#", "\n"),
              style: TextStyle(fontSize: 16),
            ).padding(all: 10),
          );
        },
      ),
    );
  }
}
