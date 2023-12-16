import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/routes.dart';
import 'package:note_taking_app/model/apis/api_response.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/utils/utils.dart';
import 'package:note_taking_app/view/screens/note_detail_screen.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';
import 'package:note_taking_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  final String title;

  const NotesScreen({Key? key, this.title = "Notes"}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NoteViewModel>().fetchNotes();
    });
  }

  void showCreateNoteModal() {
    showBottomModal(context: context, child: const CreateNoteModal());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: widget.title,
      floatingAction: showCreateNoteModal,
      child: Consumer<NoteViewModel>(
        builder: (context, noteViewModel, child) {
          switch (noteViewModel.response.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.COMPLETED:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                ),
                itemCount: noteViewModel.notes.length,
                itemBuilder: (context, index) {
                  Note note = noteViewModel.notes[index];
                  return NoteCard(note: note);
                },
              );
            case Status.ERROR:
              return Center(
                child: Text('Error: ${noteViewModel.response.message}'),
              );
            default:
              return const Center();
          }
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

  void handleTapNoteCard(BuildContext context) {
    context.go('/${ROUTES_NAME.noteCollections}/${ROUTES_NAME.notes}/${ROUTES_NAME.noteDetail}/${note.id}');
    // context.goNamed('/${ROUTES_NAME.noteDetail}/${note.id}');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleTapNoteCard(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
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

class CreateNoteModal extends StatelessWidget {
  const CreateNoteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Create a New Note",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const TextField(
          decoration: InputDecoration(
            label: Text("Title"),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            label: Text("Description"),
          ),
        ),
        const Gap(
          y: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Cancel"),
            ),
            const Gap(x: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Create"),
            ),
          ],
        )
      ],
    );
  }
}
