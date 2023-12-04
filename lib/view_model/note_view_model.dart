// viewmodel/note_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:note_taking_app/model/apis/api_response.dart';
import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/model/services/note_service.dart';

class NoteViewModel extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  final NoteService _noteService = NoteService();
  List<Note> _notes = [];
  late Note _selectedNote;

  List<Note> get notes => _notes;
  Note get selectedNote => _selectedNote;
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

  Future<void> fetchNoteById(String id) async {
    _apiResponse = ApiResponse.loading('Fetching note');
    notifyListeners();
    try {
      _selectedNote = await _noteService.fetchNoteById(id);
      _apiResponse = ApiResponse.completed(_selectedNote);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> createNote(Note note) async {
    _apiResponse = ApiResponse.loading('Creating notes');
    notifyListeners();
    try {
      await _noteService.createNote(note);
      _apiResponse = ApiResponse.completed('Create successfully');
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    _apiResponse = ApiResponse.loading('Updating note');
    notifyListeners();
    try {
      await _noteService.updateNote(note);
      _apiResponse = ApiResponse.completed('Update successfully');
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _apiResponse = ApiResponse.loading('Deleting note');
    notifyListeners();
    try {
      await _noteService.deleteNote(id);
      _apiResponse = ApiResponse.completed('Delete successfully');
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
}
