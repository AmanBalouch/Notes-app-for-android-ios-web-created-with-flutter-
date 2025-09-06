import 'package:flutter/material.dart';
import 'package:notes/helpers/ui_helper.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:notes/screens/setting_page.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:notes/helpers/DBHelper.dart';
import 'package:provider/provider.dart';

import 'add_note_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  List<Map<String, dynamic>> notesList = [];

  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _descController = TextEditingController();

  // int? updatingSrNo; // track note ID for updates

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
    // fetchNotesFromDB();
    context.read<DBprovider>().getInitialNotes();
  }

  // Future<void> fetchNotesFromDB() async {
  //   final data = await DBHelper.getinstance.readData();
  //   setState(() {
  //     notesList = data;
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    // _titleController.dispose();
    // _descController.dispose();
    super.dispose();
  }

  // void showNoteBottomSheet({required bool isUpdate, Map<String, Object?>? note}) {
  //   if (isUpdate && note != null) {
  //     _titleController.text = note[DBHelper.NOTE_COLUMN_TITLE].toString();
  //     _descController.text = note[DBHelper.NOTE_COLUMN_DESC].toString();
  //     updatingSrNo = note[DBHelper.NOTE_COLUMN_SR_N] as int;
  //   } else {
  //     _titleController.clear();
  //     _descController.clear();
  //     updatingSrNo = null;
  //   }
  //
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) => Padding(
  //       padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             isUpdate ? 'Update Note' : 'Add New Note',
  //             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 12),
  //           TextField(
  //             controller: _titleController,
  //             decoration: const InputDecoration(
  //               labelText: 'Title',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           TextField(
  //             controller: _descController,
  //             decoration: const InputDecoration(
  //               labelText: 'Description',
  //               border: OutlineInputBorder(),
  //             ),
  //             maxLines: 3,
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () async {
  //               final title = _titleController.text.trim();
  //               final desc = _descController.text.trim();
  //
  //               if (title.isEmpty || desc.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text("Both fields are required")),
  //                 );
  //                 return;
  //               }
  //
  //               if (isUpdate && updatingSrNo != null) {
  //                 await DBHelper.getinstance.updateData(title, desc, updatingSrNo!);
  //               } else {
  //                 await DBHelper.getinstance.insertNote(mtitle: title, mdescription: desc);
  //               }
  //
  //               Navigator.pop(context);
  //               fetchNotesFromDB();
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.deepPurple,
  //               foregroundColor: Colors.white,
  //             ),
  //             child: Text(isUpdate ? 'Update Note' : 'Save Note'),
  //           ),
  //           const SizedBox(height: 10),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> _confirmDelete(int srNo) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<DBprovider>().deleteNote(srNo);
              Navigator.pop(context);
              // fetchNotesFromDB();
              // context.read<DBprovider>().getNotes();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>setting_page()));
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 10),
                      Text("Settings"),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<DBprovider>(builder: (ctx,Provider, __){
        notesList=ctx.watch<DBprovider>().getNotes();
        return Padding(
          padding: UIHelper.paddingAll16,
          child: SlideTransition(
            position: _offsetAnimation,
            child: notesList.isEmpty
                ? const Center(child: Text("No notes found"))
                : ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotePage(isUpdate:true,note: note))),
                  onLongPress: () => _confirmDelete(note[DBHelper.NOTE_COLUMN_SR_N] as int),
                  child: NoteCard(
                    title: note[DBHelper.NOTE_COLUMN_TITLE].toString(),
                    content: note[DBHelper.NOTE_COLUMN_DESC].toString(),
                  ),
                );
              },
            ),
          ),
        );
      }),

      // Padding(
      //   padding: UIHelper.paddingAll16,
      //   child: SlideTransition(
      //     position: _offsetAnimation,
      //     child: notesList.isEmpty
      //         ? const Center(child: Text("No notes found"))
      //         : ListView.builder(
      //       itemCount: notesList.length,
      //       itemBuilder: (context, index) {
      //         final note = notesList[index];
      //         return GestureDetector(
      //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotePage(isUpdate:true,note: note))),
      //           onLongPress: () => _confirmDelete(note[DBHelper.NOTE_COLUMN_SR_N] as int),
      //           child: NoteCard(
      //             title: note[DBHelper.NOTE_COLUMN_TITLE].toString(),
      //             content: note[DBHelper.NOTE_COLUMN_DESC].toString(),
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNotePage(isUpdate: false)));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
