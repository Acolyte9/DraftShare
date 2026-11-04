import 'dart:collection';

import 'package:cloudy_outlook_group2/widgets/deletefilecheck.dart';
import 'package:flutter/material.dart';

import '../objects/docstoragetestjaxon.dart';

class DocumentEditorScreen extends StatefulWidget {
  final String documentId;
  final String documentName;

  const DocumentEditorScreen({
    super.key,
    required this.documentId,
    required this.documentName,
  });

  @override
  State<DocumentEditorScreen> createState() {
    return _DocumentEditorScreenState();
  }
}

class DataQueue<E> {
  final List<E> data = [];
  final int maxSize;

  DataQueue({required this.maxSize});

  void push(E value) {
    if (data.length == maxSize) {
      data.removeAt(0);
    }

    data.add(value);
  }

  E? pop() {
    if (data.isEmpty) return null;

    E value = data.removeLast();

    return value;
  }

  E? peek() {
    if (data.isEmpty) return null;

    return data.last;
  }

  bool isEmpty() {
    return data.isEmpty;
  }
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  final DocumentStorage storage = DocumentStorage();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final DataQueue<String> history = DataQueue(maxSize: 100);

  bool hasLoadedDocument = false;
  bool isSaving = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> saveDocument() async {
    setState(() {
      isSaving = true;
    });

    final title = titleController.text.trim().isEmpty
        ? 'Untitled Document'
        : titleController.text.trim();

    try {
      await storage.updateDocument(
        widget.documentId,
        title: title,
        content: textController.text,
      );

      if (!mounted) return;

      titleController.text = title;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Document saved!')));
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save document: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TextDocument>(
      stream: storage.watchDocument(widget.documentId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.documentName)),
            body: Center(
              child: Text('Could not load document: ${snapshot.error}'),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.documentName)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final document = snapshot.data!;

        if (!hasLoadedDocument) {
          titleController.text = document.title;
          textController.text = document.content;
          hasLoadedDocument = true;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 192, 128),
            title: TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Untitled Document',
                border: InputBorder.none,
              ),
            ),
            actions: [
              IconButton(
                onPressed: isSaving ? null : saveDocument,
                icon: const Icon(Icons.save),
                tooltip: 'Save document',
              ),
              IconButton(
                onPressed: isSaving ? null : undoDocument,
                icon: Icon(Icons.undo),
              ),
              IconButton(
                onPressed: isSaving ? null : deleteDocument,
                icon: Icon(Icons.delete),
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
              onChanged: (value) {
                history.push(value);
              },
              decoration: const InputDecoration(
                hintText: 'Start writing your document...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        );
      },
    );
  }

  void undoDocument() {
    if (history.isEmpty()) return;
    if (history.peek() == textController.text) history.pop();
    setState(() {
      textController.text = history.pop()!;
    });
  }

  void deleteDocument() {
    showDialog(
      context: context,
      builder: (ctx) {
        return DraftShareDeleteCheck(id: widget.documentId, storage: storage);
      },
    );
  }
}
