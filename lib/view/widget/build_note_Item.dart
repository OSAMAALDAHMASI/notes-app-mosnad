import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_task/controller/note_page_controller.dart';

class BuildNoteItem extends GetView<HomeScreenControllerImp> {
  final Map<String, dynamic> note;
  const BuildNoteItem( {super.key,required this.note,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note['title']),
      subtitle: Text(note['content']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => controller.editNote(note,context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => controller.deleteNote(note['id']),
          ),
        ],
      ),
    );
  }
}
