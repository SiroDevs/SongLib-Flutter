import 'dart:io';

import 'package:flutter/material.dart';
import 'package:songlib/presentation/theme/theme_styles.dart';
//import 'package:textstyle_extensions/textstyle_extensions.dart';
//import 'package:timeago/timeago.dart' as timeago;

import '../../../domain/entities/basic_model.dart';
import '../../../data/models/book.dart';
//import '../../theme/theme_colors.dart';
//import '../../theme/theme_styles.dart';
//import '../../theme/theme_fonts.dart';
import '../../theme/theme_colors.dart';
import '../../../core/utils/app_util.dart';

var locale = 'en';

class BookItem extends StatelessWidget {
  final Selectable<Book> item;
  final Function()? onPressed;

  const BookItem({super.key, required this.item, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.isSelected
          ? ThemeColors.primary
          : Theme.of(context).colorScheme.onInverseSurface,
      elevation: 5,
      child: Center(
        child: ListTile(
          onTap: onPressed,
          leading: Padding(
            padding: const EdgeInsets.all(Sizes.xs),
            child: Icon(
              item.isSelected
                  ? (Platform.isIOS ? Icons.check_circle : Icons.check_box)
                  : (Platform.isIOS
                        ? Icons.radio_button_unchecked
                        : Icons.check_box_outline_blank),
              color: item.isSelected
                  ? Colors.white
                  : ThemeColors.bgColorWB(context),
            ),
          ),
          title: Text(
            refineTitle(item.data.title!),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: item.isSelected
                  ? Colors.white
                  : ThemeColors.bgColorWB(context),
            ),
          ),
          subtitle: Text(
            "${item.data.songs!} ${item.data.subTitle} songs",
            style: TextStyle(
              fontSize: 18,
              color: item.isSelected
                  ? Colors.white
                  : ThemeColors.bgColorWB(context),
            ),
          ),
        ),
      ),
    );
  }
}

/*class ListedItem extends StatelessWidget {
  final Listed listed;
  final double height;
  final bool isSelected;
  final Function()? onPressed;

  const ListedItem({
    Key? key,
    required this.listed,
    required this.height,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateValue = DateTime.parse(listed.updatedAt!);
    final String lastUpdate = timeago.format(dateValue);

    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
      child: RawMaterialButton(
        fillColor: isSelected ? ThemeColors.primary : Colors.white,
        highlightColor: Colors.white.withValues(alpha: .1),
        focusElevation: 0,
        hoverColor: isSelected ? ThemeColors.primary : ThemeColors.accent,
        hoverElevation: 1,
        highlightElevation: 0,
        padding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              listed.title!,
              maxLines: 1,
              style: TextStyle(
                fontSize: height * 0.0261,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: ThemeColors.accent, height: height * 0.0049),
            const SizedBox(height: 5),
            listed.description!.isNotEmpty
                ? Text(
                    listed.description!,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: height * 0.015,
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              children: <Widget>[
                const Spacer(),
                TagView(
                  tagText:
                      '${listed.song!} song${listed.song! == 1 ? '' : 's'}',
                  height: height,
                ),
                TagView(tagText: 'Updated $lastUpdate', height: height),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}*/

// ignore: must_be_immutable

// ignore: must_be_immutable
/*class DraftItem extends StatelessWidget {
  final Draft draft;
  final double height;
  final Function()? onPressed;

  DraftItem({
    Key? key,
    required this.draft,
    required this.height,
    this.onPressed,
  }) : super(key: key);

  bool hasChorus = false;
  String chorusText = '', versesText = '';

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    final verses = draft.content!.split("##");

    if (draft.content!.contains("CHORUS")) {
      hasChorus = true;
      chorusText = tr.hasChorus;
      versesText = '${verses.length - 1} ${tr.verses}';
    } else {
      versesText = '${verses.length} ${tr.verses}';
    }

    versesText = verses.length == 1 ? versesText : '${versesText}s';

    return Hero(
      tag: 'DraftIndex_${draft.id}',
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: height * 0.0049),
          child: Padding(
            padding: EdgeInsets.all(height * 0.0049),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  draft.title!,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: height * 0.0261,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: ThemeColors.accent, height: height * 0.0049),
                Text(
                  refineContent(verses[0]),
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: height * 0.0228,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    TagView(tagText: versesText, height: height),
                    hasChorus
                        ? TagView(tagText: chorusText, height: height)
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
