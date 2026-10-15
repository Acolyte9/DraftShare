
import 'package:flutter/material.dart';
import 'Objects/docstoragetestjaxon.dart';
import 'document_editor_screen.dart';
import 'package:cloudy_outlook_group2/widgets/deletefilecheck.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({super.key});

  @override
  State<DocumentListScreen> createState() {
    return _DocumentListScreenState();
  }
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  final DocumentStorage storage = DocumentStorage();

  Future<void> createDocument() async {
    try {
      final id = await storage.createDocument(
        'Untitled Document',
        '',
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DocumentEditorScreen(
              documentId: id,
              documentName: 'Untitled Document',
            );
          },
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not create document: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraftShare'),
      ),
      body: StreamBuilder<List<TextDocument>>(
        stream: storage.watchDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load documents: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data ?? [];

          if (documents.isEmpty) {
            return const Center(
              child: Text('No documents yet. Tap + to create one.'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];

              return ListTile(
                leading: const Icon(Icons.description),
                title: Text(document.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DocumentEditorScreen(
                          documentId: document.id,
                          documentName: document.title,
                        );
                      },
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                  context: context,
                  builder: (_) {
                    return DraftShareDeleteCheck(id: document.id, storage: storage,);
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createDocument,
        tooltip: 'Create document',
        child: const Icon(Icons.add),
      ),
    );
  }
}
