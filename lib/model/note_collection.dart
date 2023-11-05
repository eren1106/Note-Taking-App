class NoteCollection {
  final String id;
  final String title;
  final String? description;
  final List<String> noteIdList;

  NoteCollection({
    required this.id,
    required this.title,
    this.description,
    this.noteIdList = const [],
  });
}