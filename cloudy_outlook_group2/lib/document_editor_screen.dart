
import 'package:flutter/material.dart';
import 'docstoragetestjaxon.dart';

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

class _DocumentEditorScreenState
    extends State<DocumentEditorScreen> {
  final DocumentStorage storage = DocumentStorage();
  final TextEditingController textController =
      TextEditingController();

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

    try {
      await storage.updateDocument(
        widget.documentId,
        content: textController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Document saved!')),
      );
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
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final document = snapshot.data!;

        if (!hasLoadedDocument) {
          textController.text = document.content;
          hasLoadedDocument = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(document.title),
            actions: [
              IconButton(
                onPressed: isSaving ? null : saveDocument,
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
      },
    );
  }
}
