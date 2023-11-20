const BASE_URL = 'http://10.0.2.2:3000/api';

class ApiRoutes {
  static const String _notes = '$BASE_URL/notes';
  static String getAllNotes() => _notes;
  static String createNote() => _notes;
  static String getNote(String noteId) => '$_notes/$noteId';
  static String updateNote(String noteId) => '$_notes/$noteId';
  static String deleteNote(String noteId) => '$_notes/$noteId';
}
