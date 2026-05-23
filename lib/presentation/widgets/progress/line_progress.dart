import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../core/theme/theme_colors.dart';

class LineProgress extends StatelessWidget {
  /// height or width of the linear percentindicator
  final double progressSize;

  /// progress value of the linear percentindicator
  final int progressVl;

  /// Color of the border for the widget
  final Color borderColor;

  /// Progress Color of the indicator
  final Color progressColor;

  /// Background Color for the widget
  final Color backgroundColor;

  /// Background Color for the widget
  final bool isVertical;

  const LineProgress({
    Key? key,
    this.progressSize = 50,
    this.progressVl = 0,
    this.borderColor = Colors.black,
    this.progressColor = ThemeColors.primary,
    this.backgroundColor = Colors.grey,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isVertical ? 7 : 0,
      child: Container(
        height: progressSize,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          boxShadow: const [BoxShadow(blurRadius: 3)],
          borderRadius: BorderRadius.all(
            Radius.elliptical(
              progressSize / 4,
              progressSize / 2,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            LinearPercentIndicator(
              percent: double.parse((progressVl / 100).toStringAsFixed(1)),
              barRadius: Radius.elliptical(
                progressSize / 4,
                progressSize / 2,
              ),
              lineHeight: progressSize,
              backgroundColor: backgroundColor,
              progressColor: progressColor,
            ),
            RotatedBox(
              quarterTurns: isVertical ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    "$progressVl %",
                    style: TextStyle(
                      fontSize: isVertical ? 50 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: progressSize,
              width: (progressSize / 2) - 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: progressColor),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(
                    progressSize / 4,
                    progressSize / 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rowWidget = Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 20,
          color: Colors.white,
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 30,
          color: Colors.white,
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 15,
          child: Row(
            children: <Widget>[
              const Spacer(),
              Container(
                width: 75,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              Container(
                width: 75,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return SkeletonLoader(
      builder: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: rowWidget,
      ),
      items: 10,
      period: const Duration(seconds: 3),
      highlightColor: ThemeColors.primary,
      direction: SkeletonDirection.ltr,
    );
  }
}
