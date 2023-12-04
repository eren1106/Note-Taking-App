import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/padding.dart';
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
  late Note note;

  @override
  void initState() {
    super.initState();
    note = context.watch<NoteViewModel>().selectedNote;
    context.read<NoteViewModel>().fetchNoteById(widget.id);
    _initializeControllers();
  }

  void _initializeControllers() {
    _titleController.text = context.read<NoteViewModel>().selectedNote.title;
    _contentController.text =
        context.read<NoteViewModel>().selectedNote.content;
  }

  void handleToggleEdit() {
    setState(() {
      _editing = !_editing;
    });
  }

  void handleSave() async {
    try {
      await context.read<NoteViewModel>().updateNote(
            note.copyWith(
              title: _titleController.text,
              content: _contentController.text,
            ),
          );
      // TODO: show success dialog
    } catch (error) {
      // TODO: show error dialog
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
          // TODO: show success dialog
        } catch (error) {
          // TODO: show error dialog
        } finally {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildEditMode() {
    return TextField(
      controller: _contentController,
      keyboardType: TextInputType.multiline,
      minLines: 20,
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Write something...',
        contentPadding: const EdgeInsets.all(16),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.purple[50],
      ),
    );
  }

  Widget _buildDisplayMode() {
    return Text(
      note.content,
      style: KTextStyle.n14,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: note.title,
      child: Consumer<NoteViewModel>(
        builder: (context, noteViewModel, child) {
          switch (noteViewModel.response.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _editing
                            ? Expanded(child: _buildEditMode())
                            : Text(
                                note.title,
                                style: KTextStyle.b19,
                              ),
                        _editing
                            ? Container()
                            : Row(
                                children: [
                                  IconButton(
                                    onPressed: handleToggleEdit,
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      handleDelete(context, note.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const Gap(y: 12),
                    _editing ? _buildEditMode() : _buildDisplayMode(),
                    const Gap(y: 12),
                    _editing
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _editing = false;
                                    _initializeControllers();
                                  });
                                },
                                child: const Text("Cancel"),
                              ),
                              const Gap(x: 16),
                              ElevatedButton(
                                onPressed: handleSave,
                                child: const Text("Save"),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
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
