import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/mocks.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/utils/utils.dart';
import 'package:note_taking_app/view/screens/note_detail_screen.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';

class StickyNotesScreen extends StatefulWidget {
  const StickyNotesScreen({Key? key}) : super(key: key);

  @override
  State<StickyNotesScreen> createState() => _StickyNotesScreenState();
}

class _StickyNotesScreenState extends State<StickyNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: "Sticky Notes",
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
        ),
        itemCount: mockNotes.length,
        itemBuilder: (context, index) {
          Note note = mockNotes[index];
          return NoteCard(note: note);
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    super.key,
    required this.note,
  });

  void handleTapCollectionCard(BuildContext context) {
    navigatorPush(
      context,
      NoteDetailScreen(
        id: note.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleTapCollectionCard(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(y: 20),
              Text(note.content),
            ],
          ),
        ),
      ),
    );
  }
}
