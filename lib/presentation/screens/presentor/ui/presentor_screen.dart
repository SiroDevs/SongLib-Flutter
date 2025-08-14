import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:window_manager/window_manager.dart';

import '../../../../core/di/injectable.dart';
import '../../../../core/utils/app_util.dart';
import '../../../../core/utils/constants/pref_constants.dart';
import '../../../../data/models/models.dart';
import '../../../../data/repositories/pref_repository.dart';
import '../../../blocs/presentor/presentor_bloc.dart';
import '../../../widgets/action/fab_widget.dart';
import '../../../widgets/presentor/slide_container.dart';
import '../../../widgets/presentor/indicators.dart';
import '../../../widgets/progress/custom_snackbar.dart';
import '../../../widgets/progress/general_progress.dart';
import '../../../theme/theme_colors.dart';
import '../../common/app_intents.dart';
import '../common/presentor_utils.dart';
import '../common/slide_utils.dart';

part 'widgets/fab_widget.dart';
part 'widgets/presentor_body.dart';
part 'widgets/presentor_details.dart';
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
  List<String> songVerses = [];
  List<Tab> widgetTabs = [];
  List<Widget> widgetContent = [];

  @override
  void initState() {
    super.initState();
    song = widget.song;
    if (song.content.contains("CHORUS")) {
      hasChorus = true;
    }
    songTitle = songItemTitle(song.songNo, widget.song.title);
    songBook = refineTitle(song.songbook);
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setFullScreen(true);
    }
  }

  @override
  void dispose() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setFullScreen(false);
    }
    super.dispose();
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
            CustomSnackbar.show(
              context,
              feedbackMessage(state.feedback, l10n),
            );
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
          } else if (state is PresentorLoadedState) {
            setState(() {
              songVerses = state.songVerses!;
              widgetTabs = state.widgetTabs!;
              widgetContent = state.widgetContent!;
            });
          }
        },
        builder: (context, state) {
          return state.maybeWhen(
            progress: () => Scaffold(body: CircularProgress()),
            orElse: () => PresentorBody(parent: this),
          );
        },
      ),
    );
  }
}
