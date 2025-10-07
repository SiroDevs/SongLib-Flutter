import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:window_manager/window_manager.dart';

import '../../../../core/di/injectable.dart';
import '../../../../core/utils/app_util.dart';
import '../../../../core/utils/constants/pref_constants.dart';
import '../../../../core/utils/font_utils.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/pref_repository.dart';
import '../../../blocs/presentor/presentor_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/action/fab_widget.dart';
import '../../../widgets/presentor/slide_container.dart';
import '../../../widgets/progress/custom_snackbar.dart';
import '../../../theme/theme_colors.dart';
import '../../common/app_intents.dart';
import '../../common/theme_button.dart';
import '../common/presentor_utils.dart';
import '../common/slide_utils.dart';

part 'widgets/fab_widget.dart';
part 'presentor_details.dart';
part 'widgets/presentor_slide.dart';

class PresentorScreen extends StatefulWidget {
  final SongExt song;
  final Book book;
  final List<SongExt> songs;

  const PresentorScreen({
    super.key,
    required this.song,
    required this.book,
    required this.songs,
  });

  @override
  State<PresentorScreen> createState() => PresentorScreenState();
}

class PresentorScreenState extends State<PresentorScreen> {
  late AppLocalizations l10n;
  late SongExt song;
  late String songTitle, songBook;
  bool hasChorus = false, likeChanged = false, slideVertical = true;

  @override
  void initState() {
    super.initState();
    song = widget.song;
    hasChorus = song.content.contains("CHORUS");
    songTitle = songItemTitle(song.songNo, widget.song.title);
    songBook = refineTitle(song.songbook);
    // setFullScreen(true);
  }

  @override
  void dispose() {
    setFullScreen(false);
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      song.liked = !song.liked;
      likeChanged = true;
    });
    String message = song.liked ? l10n.songLiked : l10n.songDisliked;
    CustomSnackbar.show(context, message, isSuccess: song.liked);
  }

  Future<void> setFullScreen(bool value) async {
    await windowManager.setFullScreen(value);
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => PresentorBloc()..add(LoadSong(widget.song)),
      child: BlocConsumer<PresentorBloc, PresentorState>(
        listener: (context, state) {
          if (state is PresentorFailureState) {
            CustomSnackbar.show(context, feedbackMessage(state.feedback, l10n));
          } else if (state is PresentorLikedState) {
            setState(() {
              song.liked = !song.liked;
              likeChanged = true;
            });
            if (state.liked) {
              CustomSnackbar.show(context, l10n.songLiked, isSuccess: true);
            } else {
              CustomSnackbar.show(context, l10n.songDisliked);
            }
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) async {
              if (didPop) {
                return;
              }
              if (context.mounted) {
                Navigator.pop(context, likeChanged);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('$songTitle - $songBook'),
                actions: [
                  Tooltip(
                    message: song.liked ? l10n.songDislike : l10n.songLike,
                    child: IconButton(
                      onPressed: _toggleLike,
                      icon: Icon(
                        song.liked ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ),
                  ThemeButton(),
                  SizedBox(width: 20),
                ],
              ),
              body: PresentorDetails(parent: this),
            ),
          );
        },
      ),
    );
  }
}
