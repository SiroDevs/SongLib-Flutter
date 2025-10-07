import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as logging show log;

import 'package:flutter/material.dart';

import '../../presentation/l10n/app_localizations.dart';

enum IndicatorSide { start, end }

void logger(String message) {
  return logging.log('''
$message
  ''');
}

String getThemeModeString(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return 'Light';

    case ThemeMode.dark:
      return 'Dark';

    default:
      return 'System Theme';
  }
}

/// Filter out unwanted characters
String? filterString(String input) {
  RegExp regex = RegExp(r': (.+?) :');
  RegExpMatch? match = regex.firstMatch(input);
  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }
  return input;
}

String feedbackMessage(String code, AppLocalizations tr) {
  switch (code) {
    case '0':
      return tr.labelError0;
    case '404':
      return tr.labelError404;
    case '500':
      return tr.labelError500;
    case '504':
      return tr.labelError504;
    case '999':
      return tr.labelError999;
    case '1000':
      return tr.labelError1000;
    default:
      return code;
  }
}

String emptyStateMessage(String code, AppLocalizations tr) {
  switch (code) {
    case '0':
      return tr.labelFeedback0;
    case '404':
      return tr.labelFeedback404;
    case '500':
      return tr.labelFeedback500;
    case '504':
      return tr.labelFeedback504;
    case '999':
      return tr.labelFeedback999;
    case '1000':
      return tr.labelFeedback1000;
    default:
      return code;
  }
}

dynamic tryJsonDecode(String source) {
  try {
    return jsonDecode(source);
  } catch (e) {
    return null;
  }
}

void getFrequencyParams(
    List<String> frequencies, List<String> productFrequency) {
  for (var item in productFrequency) {
    switch (item) {
      case '1':
        frequencies.add('Monthly');
        break;
      case '3':
        frequencies.add('Quarterly');
        break;
      case '6':
        frequencies.add('Biannually');
        break;
      case '12':
        frequencies.add('Annually');
        break;
      case '99':
        frequencies.add('Single Premium');
        break;
    }
  }
}

Future<bool> isKeyboardShowing(BuildContext context) async {
  // ignore: unnecessary_null_comparison
    return View.of(context).viewInsets.bottom > 0;
}

Future<void> closeKeyboard(BuildContext context) async {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

String? textValidator(String? value) {
  if (value!.isEmpty) {
    return 'This field is required';
  }
  return null;
}

bool isNumeric(String s) {
  // ignore: unnecessary_null_comparison
  return double.tryParse(s) != null;
}

extension StringExtension on String {
  String camelCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll('_', '')}";
  }
}

fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

List<String> generateDropDownItems({
  String initial = '',
  int? lowerLimit,
  int? upperLimit,
  bool incremental = true,
  int minLength = 2,
}) {
  List<String> temp = [], items = [];
  temp.add(initial);
  if (incremental) {
    for (int i = lowerLimit!; i < upperLimit! + 1; i++) {
      temp.add(i.toString());
    }
  } else {
    for (int i = upperLimit!; i > lowerLimit! - 1; i--) {
      temp.add(i.toString());
    }
  }
  for (var item in temp) {
    if (item.length < minLength) {
      items.add('0$item');
    } else {
      items.add(item);
    }
  }
  return items;
}

String capitalize(String? str) {
  if (str == null || str.isEmpty) {
    return ''; 
  }
  return str.substring(0, 1).toUpperCase() + str.substring(1);
}

String truncateString(int cutoff, String myString) {
  var words = myString.split(' ');
  try {
    if (myString.length > cutoff) {
      if ((myString.length - words[words.length - 1].length) < cutoff) {
        return myString.replaceAll(words[words.length - 1], '');
      } else {
        return (myString.length <= cutoff)
            ? myString
            : myString.substring(0, cutoff);
      }
    } else {
      return myString.trim();
    }
  } catch (e) {
    return myString.trim();
  }
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

String refineTitle(String textTitle) {
  return textTitle.replaceAll("''", "'");
}

String refineContent(String contentText) {
  return contentText.replaceAll("''", "'").replaceAll("#", " ");
}

String songItemTitle(int number, String title) {
  if (number != 0) {
    return "$number. ${refineTitle(title)}";
  } else {
    return refineTitle(title);
  }
}

List<String> songVerses(String songContent) {
  List<String> verseList = [];
  var verses = songContent.split("##");

  for (final verse in verses) {
    verseList.add(verse.replaceAll("#", "\n"));
  }
  return verseList;
}

String songCopyString(String title, String content) {
  return "$title\n\n$content";
}

String bookCountString(String title, int count) {
  return '$title ($count)';
}

String lyricsString(String lyrics) {
  return lyrics.replaceAll("#", "\n").replaceAll("''", "'");
}

String songViewerTitle(int number, String title, String alias) {
  String songtitle = "$number. ${refineTitle(title)}";

  if (alias.length > 2 && title != alias) {
    songtitle = "$songtitle (${refineTitle(alias)})";
  }

  return songtitle;
}

String songShareString(String title, String content) {
  return "$title\n\n$content\n\nvia #SongLib https://songlib.vercel.app";
}

String verseOfString(String number, int count) {
  return 'VERSE $number of $count';
}
