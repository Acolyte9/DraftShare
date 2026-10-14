
import 'package:cloudy_outlook_group2/docstoragetestjaxon.dart';
import 'package:flutter/material.dart';
import 'package:cloudy_outlook_group2/pages/fileeditpage.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({
    super.key,
    required this.storage
  });

  final DocumentStorage storage;

  @override
  State<DocumentListScreen> createState() {
    return _DocumentListScreenState();
  }
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  final List<String> documents = [
    'Essay.txt',
    'Meeting Notes.txt',
    'Ideas.txt',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraftShare'),
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.description),
            title: Text(documents[index]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DraftShareFileEdit(
                      documents[index], widget.storage
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            documents.add(
              'Untitled ${documents.length + 1}.txt',
            );
          });
        },
        tooltip: 'Create document',
        child: const Icon(Icons.add),
      ),
    );
  }
}
