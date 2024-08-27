import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_task/controller/note_page_controller.dart';

import 'build_note_Item.dart';

class BuildFilteredNotesList extends GetView<HomeScreenControllerImp> {
  const BuildFilteredNotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(builder: (controller)=>ListView.builder(
    itemCount: controller.filteredNotes.length,
        itemBuilder: (context, index) => BuildNoteItem(note:controller.filteredNotes[index],),
    ));
  }
}
