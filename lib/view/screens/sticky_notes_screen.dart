import 'package:flutter/material.dart';

class StickyNotesScreen extends StatefulWidget {
  const StickyNotesScreen({Key? key}) : super(key: key);

  @override
  State<StickyNotesScreen> createState() => _StickyNotesScreenState();
}

class _StickyNotesScreenState extends State<StickyNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('StickyNotes'),
      );
  }
}
