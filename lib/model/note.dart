class Note {
  final String id;
  final String title;
  final String content;
  final DateTime? createdDateTime;
  final DateTime? updatedDateTime;

  Note({
    required this.id,
    this.title = "No title",
    required this.content,
    required this.createdDateTime,
    this.updatedDateTime,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      title: json['title'] ?? "No title",
      content: json['content'],
      createdDateTime: DateTime.parse(json['createdAt']),
      updatedDateTime: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      'content': content,
      // 'createdDateTime': createdDateTime?.toIso8601String(),
      // 'updatedDateTime': updatedDateTime?.toIso8601String(),
    };
  }
}
