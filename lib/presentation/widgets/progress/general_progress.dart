import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';

import '../../theme/theme_colors.dart';
import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';
import '../../../core/utils/constants/app_assets.dart';
import '../action/app_button.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          color: ThemeColors.primary,
          strokeWidth: 5,
          backgroundColor: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

class SmallCircularProgress extends StatelessWidget {
  const SmallCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CircularProgressIndicator(
        color: ThemeColors.primary,
        strokeWidth: 3,
        backgroundColor: Colors.white.withValues(alpha: 0.3),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String titleRetry;
  final bool showRetry;
  final VoidCallback? onRetry;
  const EmptyState({
    super.key,
    this.title =
        'Sorry, no data is available at the moment. Please check back later.',
    this.message = "",
    this.titleRetry = 'RETRY',
    this.showRetry = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.imgZeroState, height: 160, width: 160),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.titleStyle20.size(18).textHeight(1.2),
        ).center().padding(all: Sizes.l),
        const SizedBox(height: Sizes.xs),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyles.bodyStyle1.size(14).textHeight(1.2),
        ).center().padding(all: Sizes.l),
        const SizedBox(height: Sizes.l),
        if (showRetry) ...[
          [
            SizedBox().expanded(),
            AppButton(
              label: titleRetry,
              onPressed: onRetry,
              bgColor: ThemeColors.bgColorPrimary3(context),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            SizedBox().expanded(),
          ].toRow().padding(all: Sizes.l),
        ],
      ],
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
