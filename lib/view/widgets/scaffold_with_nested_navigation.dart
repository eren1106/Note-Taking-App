import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/nav_items.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: kNavItems
            .map(
              (navItem) => NavigationDestination(
                icon: Icon(navItem.iconData),
                label: navItem.label,
              ),
            )
            .toList(),
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
