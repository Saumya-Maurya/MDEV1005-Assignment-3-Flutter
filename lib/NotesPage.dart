// lib/NotesPage.dart
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];

  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: _buildNotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNoteDialog,
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notes[index]),
          onTap: () => _showNoteDialog(index),
          onLongPress: () => _deleteNoteDialog(index),
        );
      },
    );
  }

  Future<void> _showNoteDialog([int? index]) async {
    String dialogTitle = 'Add Note';
    String actionButtonText = 'Add';

    if (index != null) {
      dialogTitle = 'Edit Note';
      actionButtonText = 'Save';
      _noteController.text = notes[index];
    } else {
      _noteController.clear();
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: TextField(
            controller: _noteController,
            autofocus: true,
            maxLines: null,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _noteController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_noteController.text.isNotEmpty) {
                  setState(() {
                    if (index != null) {
                      notes[index] = _noteController.text;
                    } else {
                      notes.add(_noteController.text);
                    }
                  });
                  Navigator.of(context).pop();
                  _noteController.clear();
                }
              },
              child: Text(actionButtonText),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteNoteDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
