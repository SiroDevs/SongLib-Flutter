import 'dart:math';

import 'app_util.dart';

double calcFontSize({
  required double height,
  required String content,
  double lineHeightMultiplier = 1.2,
}) {
  var verses = content.split("##");
  final lineBreakCount = '#'.allMatches(verses[0]).length + 1;
  final availableHeight = height - 275;

  final heightPerLine = availableHeight / lineBreakCount;

  double calculatedFontSize = heightPerLine / lineHeightMultiplier;

  logger('Height: $height');
  logger('Height Per Line: $heightPerLine');
  logger('Line break count: $lineBreakCount');
  logger('Final font size: $calculatedFontSize');

  return calculatedFontSize;
}

double getFontSize(int characters, double height, double width) {
  return sqrt((height * width) / characters);
}
