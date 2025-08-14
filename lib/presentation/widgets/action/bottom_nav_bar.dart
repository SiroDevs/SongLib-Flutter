import 'package:flutter/material.dart';

import '../../../core/di/injectable.dart';
import '../../theme/theme_colors.dart';
import '../../../domain/entities/basic_model.dart';
import '../../../data/repositories/pref_repository.dart';
import 'app_nav_icon.dart';

/// Custom Bottom Navigation Bar that will handle the page to be displayed on the dashboard
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onPageChange,
    required this.pages,
    super.key,
  });

  final int selectedIndex;
  final Function(int) onPageChange;
  final List<PageItem> pages;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  /// This is used for the swipe drag gesture on the bottom nav bar
  PrefRepository prefrepo = getIt<PrefRepository>();
  bool bottomNavBarSwipeGestures = false;
  bool bottomNavBarDoubleTapGestures = false;

  double _dragStartX = 0;
  double _dragEndX = 0;

  // Handles drag on bottom nav bar to open the drawer
  void _handleDragStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
  }

  // Handles drag on bottom nav bar to open the drawer
  Future<void> _handleDragUpdate(DragUpdateDetails details) async {
    _dragEndX = details.globalPosition.dx;
  }

  // Handles drag on bottom nav bar to open the drawer
  Future<void> _handleDragEnd(
    DragEndDetails details,
    BuildContext context,
  ) async {
    if (widget.selectedIndex != 0) return;

    if (bottomNavBarSwipeGestures == false) return;

    final delta = _dragEndX - _dragStartX;

    // Set some threshold to also allow for swipe up to reveal FAB
    if (delta > 20) {
      if (context.mounted) Scaffold.of(context).openDrawer();
    } else if (delta < 0) {
      if (context.mounted) Scaffold.of(context).closeDrawer();
    }

    _dragStartX = 0.0;
  }

  // Handles double-tap to open the drawer
  Future<void> _handleDoubleTap(BuildContext context) async {
    if (widget.selectedIndex != 0) return;

    if (bottomNavBarDoubleTapGestures == false) return;

    final isDrawerOpen =
        context.mounted ? Scaffold.of(context).isDrawerOpen : false;

    if (isDrawerOpen) {
      if (context.mounted) Scaffold.of(context).closeDrawer();
    } else {
      if (context.mounted) Scaffold.of(context).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: (DragEndDetails dragEndDetails) =>
          _handleDragEnd(dragEndDetails, context),
      onDoubleTap: bottomNavBarDoubleTapGestures == true
          ? () => _handleDoubleTap(context)
          : null,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ThemeColors.bgColorPrimary(context),
        currentIndex: widget.selectedIndex,
        elevation: 5,
        selectedItemColor: ThemeColors.foreColorPrimary(context),
        unselectedItemColor: ThemeColors.bgColorWB(context),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        selectedLabelStyle: const TextStyle(fontSize: 12),
        onTap: widget.onPageChange,
        items: widget.pages.map((page) {
          final isActive = widget.selectedIndex == widget.pages.indexOf(page);
          return BottomNavigationBarItem(
            label: page.title,
            icon: Padding(
              padding: const EdgeInsets.all(8),
              child: AppNavIcon(
                page.icon,
                color: isActive
                    ? ThemeColors.foreColorPrimary(context)
                    : ThemeColors.bgColorWB(context),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
