# DraftShare

A cloud document editor where the user creates plain-text documents, edits and renames them, and saves them to Cloud Firestore so the same documents show up on every device.

## Who the app is for

DraftShare is for people who want a simple place to keep plain-text notes and drafts that follow them between devices, some exaples:

- Students on a group project who want one shared pool of notes (meeting notes, outlines, to-do lists) that everyone can open and edit.
- Anyone who writes something on a phone and wants to keep working on it from a laptop without emailing themselves a file.

## What it does

DraftShare keeps every document in a Cloud Firestore collection and shows them in a live list. Tapping **+** creates a new document and opens it in the editor. In the editor you can rename the document by editing the title at the top, write in a full-screen text box, and tap the save icon to write the title and text back to the cloud. Because every device reads from the same collection, a document created or saved on one device shows up on the others.

## Why it's useful

- Your text lives in the cloud, not on one device, so closing the app or switching devices never loses a document.
- There is nothing to export, attach, or upload to move a note between devices.
- The document list updates live, so a new or renamed document appears without refreshing.
- All storage code lives in one class (`DocumentStorage`), so the screens never talk to Firebase directly. That makes the app easy to read, change, and test.

## Features

- Live document list from Cloud Firestore
- Create a new document with one tap
- Edit the document title and text in the editor
- Save changes back to the cloud, with a confirmation message
- Same documents on every device
- Navigation between the list screen and the editor screen
- Delete confirmation dialog (built, not yet connected to the list)

### Known limitations

- Saving is manual. Changes are only written when you tap the save icon.
- Last save wins. If two people save the same document, the later save overwrites the earlier one.
- The editor loads a document's text once, so reopen a document to see changes saved from another device. The list does update live.
- There is no delete button in the app yet, no `.txt` file upload, and the title can only be changed after the document is created.
- There is no sign-in. The Firestore rules are open on purpose for this class project, so anyone with the app can read and write every document.

## Screenshots

The right side of each screenshot is the Firebase console, so you can see the data change in the cloud.

![Empty_Start](images/Blank_Screen.png)

![New_Document](images/Fresh_Create.png)

![Rename_and_Save](images/Updated_On_Editor.png)

![List_Updated](images/Updated_On_List.png)


## Built with / Resources

[Flutter](https://flutter.dev/)

[Dart](https://dart.dev/)

[Firebase](https://firebase.google.com/)

- [Firebase_setup]

Add Firebase to a Flutter app: https://firebase.google.com/docs/flutter/setup

Get to know Firebase for Flutter (codelab): https://firebase.google.com/codelabs/firebase-get-to-know-flutter

firebase_core package: https://pub.dev/packages/firebase_core

Firebase console: https://console.firebase.google.com/

- [Cloud_Firestore_storage]

cloud_firestore package: https://pub.dev/packages/cloud_firestore

Get started with Cloud Firestore: https://firebase.google.com/docs/firestore/quickstart?platform=flutter

Cloud Firestore data model (collections and documents): https://firebase.google.com/docs/firestore/data-model

Add data: https://firebase.google.com/docs/firestore/manage-data/add-data

Delete data: https://firebase.google.com/docs/firestore/manage-data/delete-data

Realtime updates (snapshot listeners): https://firebase.google.com/docs/firestore/query-data/listen

Security rules: https://firebase.google.com/docs/firestore/security/get-started

Cloud Storage for Firebase (considered, not used): https://firebase.google.com/docs/storage

- [Async_and_streams]

Futures, async, and await: https://dart.dev/libraries/async/async-await

Streams: https://dart.dev/libraries/async/using-streams

StreamBuilder: https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html

- [Dart_language]

Classes: https://dart.dev/language/classes

Constructors: https://dart.dev/language/constructors

Null safety: https://dart.dev/null-safety

late variables: https://dart.dev/language/variables#late-variables

Packages: https://dart.dev/guides/packages

- [Layout_and_screens]

Layouts in Flutter: https://docs.flutter.dev/ui/layout

MaterialApp: https://api.flutter.dev/flutter/material/MaterialApp-class.html

Scaffold: https://api.flutter.dev/flutter/material/Scaffold-class.html

AppBar: https://api.flutter.dev/flutter/material/AppBar-class.html

ListView: https://api.flutter.dev/flutter/widgets/ListView-class.html

ListTile: https://api.flutter.dev/flutter/material/ListTile-class.html

FloatingActionButton: https://api.flutter.dev/flutter/material/FloatingActionButton-class.html

- [Text_input_and_feedback]

TextField: https://api.flutter.dev/flutter/material/TextField-class.html

TextEditingController: https://api.flutter.dev/flutter/widgets/TextEditingController-class.html

SnackBar: https://api.flutter.dev/flutter/material/SnackBar-class.html

AlertDialog: https://api.flutter.dev/flutter/material/AlertDialog-class.html

- [Navigation_between_screens]

Navigator: https://api.flutter.dev/flutter/widgets/Navigator-class.html

MaterialPageRoute: https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html

Navigation basics: https://docs.flutter.dev/cookbook/navigation/navigation-basics

- [State_management_basics]

StatefulWidget/State: https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html

setState: https://api.flutter.dev/flutter/widgets/State/setState.html

Ephemeral state vs app state: https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app

- [Testing]

Testing Flutter apps: https://docs.flutter.dev/testing/overview

Introduction to widget testing: https://docs.flutter.dev/cookbook/testing/widget/introduction

- [Style_and_documentation]

Effective Dart: Style: https://dart.dev/effective-dart/style

Effective Dart: Documentation: https://dart.dev/effective-dart/documentation

- [Git_and_GitHub]

Fork a repo: https://docs.github.com/en/get-started/quickstart/fork-a-repo

About pull requests: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests


## License

MIT License. See [LICENSE](LICENSE).
