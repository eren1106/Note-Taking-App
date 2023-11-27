import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/padding.dart';
import 'package:note_taking_app/constants/text_styles.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/utils/utils.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';
import 'package:note_taking_app/view_model/note_view_model.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  bool _isEdit = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _titleController.text = widget.note.title;
      _contentController.text = widget.note.content;
    });
    super.initState();
  }

  void handleToggleEdit() {
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  void handleSave() async{
    await context.read<NoteViewModel>().updateNote(widget.note.copyWith(
      title: _titleController.text,
      content: _contentController.text,
    ));
    // TODO: show success/error dialog
    handleToggleEdit();
  }

  void handleDelete(BuildContext context, String id) {
    showCustomDialog(
      context: context,
      title: "Delete Confirmation",
      content: "Are you sure want to delete this note?",
      onConfirm: () async {
        await context.read<NoteViewModel>().deleteNote(id);
        // TODO: show success/error dialog
        Navigator.pop(context);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      title: widget.note.title,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isEdit
                    ? Expanded(
                        child: TextField(
                          controller: _titleController,
                        ),
                      )
                    : Text(
                        widget.note.title,
                        style: KTextStyle.b19,
                      ),
                _isEdit
                    ? Container()
                    : Row(
                        children: [
                          IconButton(
                            onPressed: handleToggleEdit,
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              handleDelete(context, widget.note.id);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
              ],
            ),
            const Gap(y: 12),
            _isEdit
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
                    widget.note.content,
                    style: KTextStyle.n14,
                  ),
            const Gap(y: 12),
            _isEdit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: handleToggleEdit,
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
      ),
    );
  }
}
