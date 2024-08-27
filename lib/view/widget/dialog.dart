import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDialog extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;
  final String? initialTags;
  final String? initialReminderTime;
  final bool initialIsPinned;

  NoteDialog({
    this.initialTitle,
    this.initialContent,
    this.initialTags,
    this.initialReminderTime,
    this.initialIsPinned = false,
  });

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();
  final _reminderTimeController = TextEditingController();
  bool _isPinned = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _contentController.text = widget.initialContent ?? '';
    _tagsController.text = widget.initialTags ?? '';
    _reminderTimeController.text = widget.initialReminderTime ?? '';
    _isPinned = widget.initialIsPinned;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTitle == null ? 'Create Note' : 'Edit Note'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Note Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Note Content',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _tagsController,
              decoration: const InputDecoration(
                hintText: 'Tags (comma-separated)',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _reminderTimeController,
              decoration: const InputDecoration(
                hintText: 'Reminder Time',
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('Pin Note'),
              value: _isPinned,
              onChanged: (value) {
                setState(() {
                  _isPinned = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'title': _titleController.text,
              'content': _contentController.text,
              'tags': _tagsController.text,
              'reminderTime': _reminderTimeController.text,
              'isPinned': _isPinned,
            });
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}