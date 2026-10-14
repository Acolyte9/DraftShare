import 'package:flutter/material.dart';
import 'document_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DraftShare',
      home: const DocumentListScreen(),
    );
  }
}