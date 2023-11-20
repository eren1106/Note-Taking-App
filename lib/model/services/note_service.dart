// service/note_service.dart
import 'package:dio/dio.dart';
import 'package:note_taking_app/constants/api.dart';
import 'package:note_taking_app/constants/mocks.dart';
import 'package:note_taking_app/model/note.dart';

class NoteService {
  final Dio _dio = Dio();

  Future<List<Note>> fetchNotes() async {
    try {
      final res = await _dio.get(ApiRoutes.getAllNotes());
      if (res.statusCode == 200) {
        List<Note> data = (res.data['data'] as List<dynamic>).map((item) => Note.fromJson(item)).toList();
        print(data);
        return data;
      } else {
        throw Exception('Failed to fetch notes');
      }
    } catch (error) {
      throw Exception('Failed to fetch notes: $error');
    }
  }
}
