import 'package:flutter/material.dart';
import 'package:note_taking_app/view/screens/home_screen.dart';
import 'package:note_taking_app/view/screens/note_collections_screen.dart';
import 'package:note_taking_app/view/screens/settings_screen.dart';
import 'package:note_taking_app/view/screens/sticky_notes_screen.dart';

class NavItem {
  IconData iconData;
  String label;
  Widget screen;

  NavItem({
    required this.iconData,
    required this.label,
    required this.screen,
  });
}

final List<NavItem> kNavItems = [
  NavItem(
    iconData: Icons.home,
    label: 'Home',
    screen: const HomeScreen(),
  ),
  NavItem(
    iconData: Icons.dashboard,
    label: 'Note Collections',
    screen: const NoteCollectionsScreen(),
  ),
  NavItem(
    iconData: Icons.note_alt,
    label: 'Sticky Notes',
    screen: const StickyNotesScreen(),
  ),
  NavItem(
    iconData: Icons.settings,
    label: 'Settings',
    screen: const SettingsScreen(),
  ),
];
