import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class PresentorIndicator extends StatelessWidget {
  final double? width;
  final double? left;
  final double? right;
  final Animation<double> animation;

  const PresentorIndicator({
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
      width: width,
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
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: ThemeColors.bgColorAccent(context),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class IndicatorItem extends StatelessWidget {
  final double? width;
  final Widget? child;
  final AlignmentGeometry alignment;
  final Function()? onTap;
  final bool? isSelected;

  const IndicatorItem({
    super.key,
    required this.width,
    required this.child,
    required this.alignment,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected! ? Colors.transparent : ThemeColors.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        alignment: alignment,
        child: child,
      ),
    );
  }
}
