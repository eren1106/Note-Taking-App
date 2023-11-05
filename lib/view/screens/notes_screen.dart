import 'package:flutter/material.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';

class NotesScreen extends StatefulWidget {
  final String title;

  const NotesScreen({Key? key, this.title = "Notes"}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: widget.title,
      child: const Center(
        child: Text('Notes Screen'),
      ),
    );
  }
}
