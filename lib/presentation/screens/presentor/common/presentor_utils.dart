import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/app_util.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../data/models/songext.dart';
import '../../../widgets/presentor/presentor.dart';

Future<Map<String, dynamic>> loadSong(SongExt song) async {
  var hasChorus = false;
  List<Tab> tabs = [];
  List<String> labels = [];
  List<String> stanzas = [];

  try {
    var verses = song.content.split("##");
    final int verseCount = verses.length;

    if (song.content.contains("CHORUS")) {
      hasChorus = true;
    }

    if (hasChorus) {
      final String chorus = verses[1].replaceAll("CHORUS#", "");

      labels.add("1");
      labels.add("C");
      stanzas.add(verses[0]);
      stanzas.add(chorus);

      for (int i = 2; i < verseCount; i++) {
        labels.add(i.toString());
        labels.add("C");
        stanzas.add(verses[i]);
        stanzas.add(chorus);
      }
    } else {
      for (int i = 0; i < verseCount; i++) {
        labels.add((i + 1).toString());
        stanzas.add(verses[i]);
      }
    }

    for (final label in labels) {
      tabs.add(
        Tab(
          child: SliderNumbers(label: label, fontSize: 0.5 * .75),
        ),
      );
    }

    return {'tabs': tabs, 'stanzas': stanzas};
  } catch (e) {
    return {'tabs': [], 'stanzas': []};
  }
}

List<Widget> presentorWidgets(
  String title,
  String book,
  double fontSize,
  List<String> stanzas,
) {
  try {
    List<Widget> slides = [];
    for (final stanza in stanzas) {
      slides.add(
        SliderContent(
          lyrics: stanza,
          fontSize: fontSize,
          onDoubleTap: () => Share.share(
            '${stanza.replaceAll("#", "\n")}\n\n$title,\n$book',
            subject: 'Share verse',
          ),
          //onLongPress: () => copyVerse(verse),
        ),
      );
    }

    return slides;
  } catch (e) {
    return [];
  }
}

String getSongContent(SongExt song) {
  var songBook = refineTitle(song.songbook);
  var songTitle = songItemTitle(song.songNo, song.title);
  var songContent = song.content.replaceAll("#", "\n");
  return '$songTitle - $songBook\n\n$songContent';
}

Future<void> shareSong(SongExt song) async {
  try {
    Share.share(
      getSongContent(song) + AppConstants.fromApp,
      subject: 'Share the song: ${song.title}',
    );
  } catch (e) {
    logger('Error during sharing song: $e');
  }
}

Future<void> copySong(SongExt song) async {
  try {
    await Clipboard.setData(
      ClipboardData(text: getSongContent(song) + AppConstants.fromApp),
    );
    /*showToast(
      text: '${song.title} copied!',
      state: ToastStates.success,
    );*/
  } catch (e) {
    logger('Error during copying song: $e');
  }
}

Future<void> copyVerse(String songTitle, String songBook, String lyrics) async {
  try {
    await Clipboard.setData(
      ClipboardData(
        text:
            '${lyrics.replaceAll("#", "\n")}'
            '\n\n$songTitle,\n$songBook',
      ),
    );
    /*showToast(
      text: 'Verse copied',
      state: ToastStates.success,
    );*/
  } catch (e) {
    logger('Error during copying verse: $e');
  }
}
