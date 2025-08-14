import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../../data/models/songext.dart';
import '../../theme/theme_colors.dart';
import '../../theme/theme_fonts.dart';
import '../../../core/utils/app_util.dart';
import 'tag_item.dart';

// ignore: must_be_immutable
class SearchSongItem extends StatelessWidget {
  final SongExt song;
  final double height;
  final bool isSelected;
  final bool isSearching;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;

  SearchSongItem({
    super.key,
    required this.song,
    required this.height,
    this.isSelected = false,
    this.isSearching = false,
    this.onTap,
    this.onDoubleTap,
  });

  bool hasChorus = false;
  String chorusText = '', versesText = '';
  ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    final verses = song.content.split("##");

    if (song.content.contains("CHORUS")) {
      hasChorus = true;
      chorusText = 'Chorus';
      versesText = '${verses.length - 1} V';
    } else {
      versesText = '${verses.length} V';
    }

    versesText = verses.length == 1 ? versesText : '${versesText}s';

    var btnContents = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        [
          Text(
            songItemTitle(song.songNo, song.title),
            maxLines: 1,
            style: TextStyles.headingStyle3.bold,
          ).expanded(),
          TagItem(tagText: versesText, height: height),
          if (hasChorus) TagItem(tagText: chorusText, height: height),
          Icon(
            song.liked ? Icons.favorite : Icons.favorite_border,
            color: ThemeColors.foreColorBW(context),
          )
        ].toRow(),
        const SizedBox(height: 3),
        Divider(color: ThemeColors.foreColorPrimary2(context), height: 1),
        [
          Text(
            refineContent(verses[0]),
            maxLines: 2,
            style: TextStyles.bodyStyle2.textHeight(1.5),
          ).expanded(),
        ].toRow(),
        if (isSearching) ...[
          TagItem(tagText: refineTitle(song.songbook), height: height),
        ],
      ],
    );
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      hoverColor: ThemeColors.accent2,
      child: Container(
        color: isSelected ? ThemeColors.primary : Colors.transparent,
        padding: EdgeInsets.all(5),
        child: btnContents,
      ),
    );
  }
}
