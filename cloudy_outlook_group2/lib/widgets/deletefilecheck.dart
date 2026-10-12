// import 'package:to_dont_list/objects/item.dart';
import 'package:flutter/material.dart';
import 'package:cloudy_outlook_group2/docstoragetestjaxon.dart';

// typedef ToDoListDeletedCallback = Function(
//     String item
//     );

class DraftShareDeleteCheck extends StatefulWidget {
  const DraftShareDeleteCheck({
    super.key,
    required this.file,
    required this.storage,
  });

  final TextDocument file;
  // ToDoDeleteCheck(Item item) : item = item;
  final DocumentStorage storage;

  @override
  State<DraftShareDeleteCheck> createState() => _DraftShareDeleteCheckState();
}

class _DraftShareDeleteCheckState extends State<DraftShareDeleteCheck> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  // final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.grey);

  // String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Item?'),
      // content: TextField(
      //   onChanged: (value) {
      //     setState(() {
      //       valueText = value;
      //     });
      //   },
      //   controller: _inputController,
      //   decoration: const InputDecoration(hintText: "type something here"),
      // ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          onPressed: () {
            setState(() {
              widget.storage.deleteDocument(widget.file.id);
              Navigator.pop(context);
            });
          },
          child: const Text('OK'),
        ),
        
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        // ValueListenableBuilder<TextEditingValue>(
        //   valueListenable: _inputController,
        //   builder: (context, value, child) {
        //     return ElevatedButton(
        //       key: const Key("OKButton"),
        //       style: yesStyle,
        //       onPressed: value.text.isNotEmpty
        //           ? () {
        //               setState(() {
        //                 widget.onDeleteItem(item);
        //                 Navigator.pop(context);
        //               });
        //             }
        //           : null,
        //       child: const Text('OK'),
        //     );
        //   },
        // ),
      ],
    );
  }
}
