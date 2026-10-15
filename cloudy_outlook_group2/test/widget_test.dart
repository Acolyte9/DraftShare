// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloudy_outlook_group2/pages/fileeditpage.dart';
import 'package:cloudy_outlook_group2/Objects/docstoragetestjaxon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudy_outlook_group2/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    TextDocument testtextdocument = TextDocument(id: "0", title: "title", content: "content", updatedAt: 0);
    DocumentStorage storage = DocumentStorage();
    await tester.pumpWidget(MaterialApp(home: DraftShareFileEdit(file: testtextdocument, storage: storage,)));

    expect(find.byType(TextField), findsOne);

    await tester.tap(find.byType(TextField));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    // await tester.tap(find.byKey(const Key("OKButton")));
    // await tester.pump();
    // expect(find.text("hi"), findsOneWidget);

    // final listItemFinder = find.byType(ToDoListItem);

    final textFinder = find.text("hi");

    expect(textFinder, findsNWidgets(1));
  });
}
