
import 'package:flutter/material.dart';

class DocumentEditorScreen extends StatefulWidget {
  final String documentName;

  const DocumentEditorScreen({
    super.key,
    required this.documentName,
  });

  @override
  State<DocumentEditorScreen> createState() {
    return _DocumentEditorScreenState();
  }
}

class _DocumentEditorScreenState
    extends State<DocumentEditorScreen> {
  final TextEditingController textController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = '';
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentName),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Save button pressed!'),
                ),
              );
            },
            icon: const Icon(Icons.save),
            tooltip: 'Save document',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: textController,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            hintText: 'Start writing your document...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
