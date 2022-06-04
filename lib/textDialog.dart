import 'package:flutter/material.dart';

Future textDialog(
  BuildContext context, {
  required String title,
  required String value,
}) =>
    showDialog(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter the new value",
            border: OutlineInputBorder(),
          ),
        ),
        
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.grey
            ),
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.grey
            ),
            child: Text('Done'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(controller.text),
          ),
        ],
      );
}
