import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../theme/theme_fonts.dart';
import '../../theme/theme_styles.dart';

class SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.headingStyle3,
        ).padding(left: Sizes.sm, top: Sizes.sm),
        Card(
          child: ListTile(
            leading: Icon(icon),
            title: Text(subtitle),
            subtitle: Text(description),
            onTap: () => onTap,
          ),
        ),
      ],
    );
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: Sizes.xs),
              Text(
                title,
                style: TextStyles.headingStyle3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyles.bodyStyle2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null)
                Align(alignment: Alignment.bottomRight, child: trailing!),
            ],
          ),
        ),
      ),
    );
  }
}
