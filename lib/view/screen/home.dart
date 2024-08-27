import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controller/note_page_controller.dart';
import '../widget/build_categorized_notesList.dart';
import '../widget/build_filtered_notes_list.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {



  @override
  Widget build(BuildContext context) {
    HomeScreenControllerImp controller = Get.put(HomeScreenControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value){
            controller.filterNotes(value);

          },
          decoration: const InputDecoration(
            hintText: 'Search notes',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              controller.createNote(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<HomeScreenControllerImp>(builder: (controller)=> Expanded(
            child: controller.searchText == null
                ? const BuildCategorizedNoteslist()
                : const BuildFilteredNotesList(),
          )),
        ],
      ),
    );
  }


}



