// service/note_service.dart
import 'package:dio/dio.dart';
import 'package:note_taking_app/constants/api.dart';
import 'package:note_taking_app/model/note.dart';

class NoteService {
  final Dio _dio = Dio();

  Future<List<Note>> fetchNotes() async {
    try {
      final res = await _dio.get(ApiRoutes.getAllNotes());
      if (res.statusCode == 200) {
        List<Note> data = (res.data['data'] as List<dynamic>)
            .map((item) => Note.fromJson(item))
            .toList();
        print(data);
        return data;
      } else {
        throw Exception('Failed to fetch notes');
      }
    } catch (error) {
      throw Exception('Failed to fetch notes: $error');
    }
  }

  Future<Note> fetchNoteById(String id) async {
    try {
      final res = await _dio.get(ApiRoutes.getNote(id));
      if (res.statusCode == 200) {
        Note data = Note.fromJson(res.data['data']);
        print(data);
        return data;
      } else {
        throw Exception('Failed to fetch note');
      }
    } catch (error) {
      throw Exception('Failed to fetch note: $error');
    }
  }

  Future<void> createNote(Note note) async {
    try {
      final res = await _dio.post(ApiRoutes.createNote(), data: note.toJson());
      if (res.statusCode == 200) {
        print("Created successfully");
      } else {
        throw Exception('Failed to create note');
      }
    } catch (error) {
      throw Exception('Failed to create note: $error');
    }
  }

  Future<void> updateNote(Note updatedNote) async {
    try {
      final res = await _dio.put(ApiRoutes.updateNote(updatedNote.id), data: updatedNote.toJson());
      if (res.statusCode == 200) {
        print("Updated successfully");
      } else {
        throw Exception('Failed to update note');
      }
    } catch (error) {
      throw Exception('Failed to update note: $error');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      final res = await _dio.delete(ApiRoutes.deleteNote(id));
      if (res.statusCode == 200) {
        print("Deleted successfully");
      } else {
        throw Exception('Failed to delete note');
      }
    } catch (error) {
      throw Exception('Failed to delete note: $error');
    }
  }
}
