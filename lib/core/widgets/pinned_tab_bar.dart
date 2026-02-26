import 'package:flutter/material.dart';
import 'package:riverpod_app/core/constants/app_colors.dart';

class PinnedTabBar extends SliverPersistentHeaderDelegate {
  final Widget child;

  PinnedTabBar(this.child);

  @override
  double get minExtent => 48;

  @override
  double get maxExtent => 48;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: Container(color: AppColors.background, child: child),
    );
  }

  @override
  bool shouldRebuild(covariant PinnedTabBar oldDelegate) {
    return oldDelegate.child != child;
  }
}
