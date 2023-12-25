import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/text_styles.dart';
import 'package:note_taking_app/model/apis/api_response.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/utils/utils.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';
import 'package:note_taking_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final String id;

  const NoteDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  bool _editing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the note by ID
    context.read<NoteViewModel>().fetchNoteById(widget.id);
  }

  void _assignTextToController(String title, String content) {
    _titleController.text = title;
    _contentController.text = content;
  }

  void handleToggleEdit() {
    setState(() {
      _editing = !_editing;
    });
  }

  void handleSave(Note note) async {
    try {
      await context.read<NoteViewModel>().updateNote(
            note.copyWith(
              title: _titleController.text,
              content: _contentController.text,
            ),
          );
      showSnackbar(context, "Successfully updated note!");
    } catch (error) {
      showSnackbar(context, "Failed to update note. Error: $error");
    } finally {
      handleToggleEdit();
    }
  }

  void handleDelete(BuildContext context, String id) {
    showCustomDialog(
      context: context,
      title: "Delete Confirmation",
      content: "Are you sure you want to delete this note?",
      onConfirm: () async {
        try {
          await context.read<NoteViewModel>().deleteNote(id);
          showSnackbar(context, "Successfully deleted note!");
        } catch (error) {
          showSnackbar(context, "Failed to delete note. Error: $error");
        } finally {
          // Navigator.pop(context);
          context.pop();
          context.read<NoteViewModel>().fetchNotes();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewModel>(
      builder: (context, noteViewModel, child) {
        switch (noteViewModel.response.status) {
          case Status.LOADING:
            return const ScreenWrapper(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case Status.COMPLETED:
            Note note = noteViewModel.selectedNote;
            return ScreenWrapper(
              title: note.title,
              backCallback: () {
                context.read<NoteViewModel>().fetchNotes();
              },
              allowDeviceBack: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _editing
                            ? Expanded(
                                child: TextField(
                                  controller: _titleController,
                                ),
                              )
                            : Text(
                                note.title,
                                style: KTextStyle.b19,
                              ),
                        _editing
                            ? Container()
                            : Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _assignTextToController(
                                          note.title, note.content);
                                      handleToggleEdit();
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      handleDelete(context, widget.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Gap(y: 12),
                    _editing
                        ? TextField(
                            controller: _contentController,
                            keyboardType: TextInputType.multiline,
                            minLines: 20,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Write something...',
                              contentPadding: const EdgeInsets.all(16),
                              border: const OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.purple[50],
                            ),
                          )
                        : Text(
                            note.content,
                            style: KTextStyle.n14,
                          ),
                    const Gap(y: 12),
                    _editing
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _editing = false;
                                  });
                                },
                                child: const Text("Cancel"),
                              ),
                              const Gap(x: 16),
                              ElevatedButton(
                                onPressed: () {
                                  handleSave(note);
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          case Status.ERROR:
            return ScreenWrapper(
              child: Center(
                child: Text('Error: ${noteViewModel.response.message}'),
              ),
            );
          default:
            return const Center();
        }
      },
    );
  }
}
