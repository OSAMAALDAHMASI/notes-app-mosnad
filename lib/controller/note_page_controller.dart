import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../core/class/sqflite_helper.dart';
import '../view/widget/dialog.dart';


abstract class HomeScreenController extends GetxController{


}
class HomeScreenControllerImp extends HomeScreenController{
 List<Map<String, dynamic>> notes = [];
 List<Map<String, dynamic>> filteredNotes = [];
 String? searchText;
 Map<String, List<Map<String, dynamic>>> categorizedNotes = {};

 @override
  void onInit() {
    super.onInit();
  loadNotes();
  }


 Future<void> loadNotes() async {
  final loadedNotes = await NoteRepository.getNotes();
  notes = loadedNotes;
  filteredNotes = loadedNotes;
  categorizeNotes(loadedNotes);
  update();
 }

 void categorizeNotes(List<Map<String, dynamic>> notes) {
  categorizedNotes = {};
  for (final note in notes) {
   final tags = note['tags'] as String? ?? '';
   for (final tag in tags.split(',')) {
    final trimmedTag = tag.trim();
    if (categorizedNotes.containsKey(trimmedTag)) {
     categorizedNotes[trimmedTag]!.add(note);
    } else {
     categorizedNotes[trimmedTag] = [note];
    }
   }
  }
  update();
 }

 void filterNotes(String? value) {
   searchText = value;
   update();
   if (searchText == null || searchText!.isEmpty) {

    filteredNotes = notes;
    update();
   } else {

    filteredNotes = notes.where((note) {

     final title = note['title'] as String? ?? '';
     final content = note['content'] as String? ?? '';
     final tags = note['tags'] as String? ?? '';
     return title.toLowerCase().contains(searchText!.toLowerCase()) ||
         content.toLowerCase().contains(searchText!.toLowerCase()) ||
         tags.toLowerCase().contains(searchText!.toLowerCase());
    }).toList();
    print(filteredNotes);
    update();
   }

 }

  createNote(context) async {
  final result = await showDialog<Map<String, dynamic>?>(
   context: context,
   builder: (context) => NoteDialog(),
  );
  if (result != null) {
   await NoteRepository.createNote(
    result['title'] as String,
    result['content'] as String,
    result['tags'] as String?,
    result['reminderTime'] as String?,
    result['isPinned'] as bool,
   );
   loadNotes();
  }
  update();
 }

 void editNote(Map<String, dynamic> note,context) async {
  final result = await showDialog<Map<String, dynamic>?>(
   context: context,
   builder: (context) => NoteDialog(
    initialTitle: note['title'] as String,
    initialContent: note['content'] as String,
    initialTags: note['tags'] as String?,
    initialReminderTime: note['reminder_time'] as String?,
    initialIsPinned: note['is_pinned'] == 1,
   ),
  );
  if (result != null) {
   await NoteRepository.updateNote(
    note['id'] as int,
    result['title'] as String,
    result['content'] as String,
    result['tags'] as String?,
    result['reminderTime'] as String?,
    result['isPinned'] as bool,
   );
   loadNotes();
  }
  update();
 }

 Future<void> deleteNote(int id) async {
  await NoteRepository.deleteNote(id);
  loadNotes();
  update();
 }


 }