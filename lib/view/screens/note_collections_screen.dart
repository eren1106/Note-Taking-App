import 'package:flutter/material.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';

class NoteCollectionsScreen extends StatefulWidget {
  const NoteCollectionsScreen({Key? key}) : super(key: key);

  @override
  State<NoteCollectionsScreen> createState() => _NoteCollectionsScreenState();
}

class _NoteCollectionsScreenState extends State<NoteCollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ScreenWrapper(
      title: "Note Collections",
      child: Center(
          child: Text('NoteCollections'),
        ),
    );
  }
}
