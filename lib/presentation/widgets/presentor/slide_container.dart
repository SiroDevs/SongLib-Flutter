import 'package:flutter/material.dart';

import '../../../core/theme/theme_colors.dart';
import '../../../core/utils/app_util.dart';
import 'indicators.dart';

class SlideContainer extends StatelessWidget {
  final List<Tab>? tabs;
  final int? selectedIndex;
  final TextDirection? direction;
  final IndicatorSide? indicatorSide;
  final double? indicatorWidth;
  final List<AnimationController?>? animationControllers;
  final ValueChanged<int>? onTabSelected;

  const SlideContainer({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.direction,
    required this.indicatorSide,
    required this.indicatorWidth,
    required this.animationControllers,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: tabs!.length,
          itemBuilder: (context, index) {
            Alignment alignment = (direction == TextDirection.rtl)
                ? Alignment.centerRight
                : Alignment.centerLeft;

            double? left = (direction == TextDirection.rtl)
                ? (indicatorSide == IndicatorSide.end ? 0 : null)
                : (indicatorSide == IndicatorSide.start ? 0 : null);
            double? right = (direction == TextDirection.rtl)
                ? (indicatorSide == IndicatorSide.start ? 0 : null)
                : (indicatorSide == IndicatorSide.end ? 0 : null);

            return Stack(
              children: <Widget>[
                TabIndicator(
                  width: indicatorWidth!,
                  left: left,
                  right: right,
                  animation: animationControllers![index]!,
                ),
                IndicatorItem(
                  width: indicatorWidth,
                  alignment: alignment,
                  isSelected: selectedIndex == index,
                  onTap: () => onTabSelected!(index),
                  child: tabs![index].child,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TabIndicator extends StatelessWidget {
  final double width;
  final double? left, right;
  final AnimationController animation;

  const TabIndicator({
    super.key,
    required this.width,
    required this.left,
    required this.right,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2,
      bottom: 2,
      width: width * 1.1,
      left: left,
      right: right,
      child: ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.primary2,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
