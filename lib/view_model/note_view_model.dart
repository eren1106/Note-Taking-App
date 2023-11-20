// viewmodel/note_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:note_taking_app/model/apis/api_response.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/model/services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  final NoteService _noteService = NoteService();
  List<Note> _notes = [];

  List<Note> get notes => _notes;
  ApiResponse get response => _apiResponse;

  Future<void> fetchNotes() async {
    _apiResponse = ApiResponse.loading('Fetching notes');
    notifyListeners();
    try {
      _notes = await _noteService.fetchNotes();
      _apiResponse = ApiResponse.completed(_notes);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
