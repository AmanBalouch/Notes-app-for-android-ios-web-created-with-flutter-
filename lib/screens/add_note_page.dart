import 'package:flutter/material.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:provider/provider.dart';

import '../helpers/DBHelper.dart';

class AddNotePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final bool isUpdate;
  final Map<String, dynamic>? note;

  AddNotePage({required this.isUpdate, this.note}) {
    if (isUpdate && note != null) {
      _titleController.text = note![DBHelper.NOTE_COLUMN_TITLE].toString();
      _descController.text = note![DBHelper.NOTE_COLUMN_DESC].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    int? updatingSrNo = isUpdate && note != null ? note![DBHelper.NOTE_COLUMN_SR_N] as int : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isUpdate ? 'Update Note' : 'Add New Note',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                final desc = _descController.text.trim();

                if (title.isEmpty || desc.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Both fields are required")),
                  );
                  return;
                }

                if (isUpdate && updatingSrNo != null) {
                  context.read<DBprovider>().updateNote(updatingSrNo, title, desc);
                } else {
                  context.read<DBprovider>().addNote(title, desc);
                }

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text(isUpdate ? 'Update Note' : 'Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
