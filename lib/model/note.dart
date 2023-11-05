class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdDateTime;
  final DateTime? updatedDateTime;

  Note({
    required this.id,
    this.title = "No title",
    required this.content,
    required this.createdDateTime,
    this.updatedDateTime,
  });
}