import 'package:flutter/material.dart';

class NoteCollectionsScreen extends StatefulWidget {
  const NoteCollectionsScreen({Key? key}) : super(key: key);

  @override
  State<NoteCollectionsScreen> createState() => _NoteCollectionsScreenState();
}

class _NoteCollectionsScreenState extends State<NoteCollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('NoteCollections'),
      );
  }
}
