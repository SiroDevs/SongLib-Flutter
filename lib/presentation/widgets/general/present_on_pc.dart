import 'package:flutter/material.dart';

import '../../../core/theme/theme_colors.dart';

class PresentOnPc extends StatefulWidget {
  final Key? key;
  final int index;
  final double? tabsWidth;
  final double? indicatorWidth;
  final List<String>? infos;
  final List<Widget>? contents;
  final Color? backgroundColor;
  final Function(int? tabIndex)? onSelect;

  const PresentOnPc({
    this.key,
    required this.infos,
    required this.contents,
    required this.index,
    this.tabsWidth = 200,
    this.indicatorWidth = 3,
    this.onSelect,
    this.backgroundColor,
  })  : assert(infos != null &&
            contents != null &&
            infos.length == contents.length),
        super(key: key);

  @override
  PresentOnPcState createState() => PresentOnPcState();
}

class PresentOnPcState extends State<PresentOnPc> with TickerProviderStateMixin {
  double targetOpacity = 1;
  List<AnimationController?>? animationControllers = [];

  @override
  Widget build(BuildContext context) {
    var indicatorContainer = SizedBox(
      height: widget.tabsWidth,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.infos!.length,
        itemBuilder: (context, index) {
          bool isSelected = index == widget.index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: RawMaterialButton(
              fillColor: isSelected ? ThemeColors.primary : Colors.white,
              highlightColor: Colors.white.withValues(alpha: .1),
              focusElevation: 0,
              hoverColor: ThemeColors.lightGrey,
              hoverElevation: 1,
              highlightElevation: 0,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              onPressed: () => widget.onSelect!(index),
              child: Text(
                widget.infos![index],
                /*style: TextStyles.Btn.bold
                    .size(30)
                    .textColor(isSelected ? Colors.white : Colors.black),*/
              ),
            ),
          );
        },
      ),
    );
    return Column(
      children: <Widget>[
        Expanded(
          child: IndexedStack(
            index: widget.index,
            children: widget.contents!,
          ),
        ),
        indicatorContainer,
        const SizedBox(height: 20),
      ],
    );
  }
}
