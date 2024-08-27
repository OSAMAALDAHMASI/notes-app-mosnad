import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_task/controller/note_page_controller.dart';

import 'build_note_Item.dart';

class BuildCategorizedNoteslist extends GetView<HomeScreenControllerImp> {

  const BuildCategorizedNoteslist( {super.key, });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(builder: (Controller)=>ListView(
      children: controller.categorizedNotes.entries.map((entry) {
        final tag = entry.key;
        final tagNotes = entry.value;
        return
          ExpansionTile(
          title: Text(tag),
          children: tagNotes.map((note) => BuildNoteItem( note: note,)).toList(),
        )
        ;
      }).toList(),
    ));
  }
}
