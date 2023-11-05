import 'package:note_taking_app/model/note.dart';
import 'package:note_taking_app/model/note_collection.dart';

final List<NoteCollection> mockNoteCollections = [
  NoteCollection(
    id: 'abc',
    title: 'To-Do',
    description: "The tasks that I'm going to do",
  ),
  NoteCollection(
    id: 'def',
    title: 'Journal',
    description: "My daily journal",
  ),
  NoteCollection(
    id: 'hij',
    title: 'Video Ideas',
    description: "I gather all my youtube ideas here",
  ),
  NoteCollection(
    id: 'abc',
    title: 'To-Do',
    description: "The tasks that I'm going to do",
  ),
  NoteCollection(
    id: 'def',
    title: 'Journal',
    description: "My daily journal",
  ),
  NoteCollection(
    id: 'hij',
    title: 'Video Ideas',
    description: "I gather all my youtube ideas here",
  ),
  NoteCollection(
    id: 'abc',
    title: 'To-Do',
    description: "The tasks that I'm going to do",
  ),
  NoteCollection(
    id: 'def',
    title: 'Journal',
    description: "My daily journal",
  ),
  NoteCollection(
    id: 'hij',
    title: 'Video Ideas',
    description: "I gather all my youtube ideas here",
  ),
];

final List<Note> mockNotes = [
  Note(
    id: '123',
    title: 'Testing 123',
    content:
        'fsfsdfsdfsdfsf dsfsdfsfsfs fsdfdsfdsfdsfdsf dsfsdfsdfdfds fdsfdsf',
    createdDateTime: DateTime.now(),
  ),
  Note(
    id: '123',
    title: 'Testing 456',
    content:
        'test test',
    createdDateTime: DateTime.now(),
  ),
  Note(
    id: '123',
    title: 'Testing 123',
    content:
        'fsfsdfsdfsdfsf dsfsdfsfsfs fsdfdsfdsfdsfdsf dsfsdfsdfdfds fdsfdsf',
    createdDateTime: DateTime.now(),
  ),
  Note(
    id: '123',
    title: 'Testing 456',
    content:
        'test test',
    createdDateTime: DateTime.now(),
  ),
  Note(
    id: '123',
    title: 'Testing 123',
    content:
        'fsfsdfsdfsdfsf dsfsdfsfsfs fsdfdsfdsfdsfdsf dsfsdfsdfdfds fdsfdsf',
    createdDateTime: DateTime.now(),
  ),
  Note(
    id: '123',
    title: 'Testing 456',
    content:
        'test test',
    createdDateTime: DateTime.now(),
  ),
];
