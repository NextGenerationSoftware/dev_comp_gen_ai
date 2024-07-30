import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VerifyImageLabel1 extends StatefulWidget {
  final XFile imageFile;
  final String label;
  const VerifyImageLabel1({
    super.key,
    required this.imageFile,
    required this.label,
  });

  @override
  State<VerifyImageLabel1> createState() => _VerifyImageLabel1State();
}

class _VerifyImageLabel1State extends State<VerifyImageLabel1> {
  late TextEditingController labelController;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.label);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Image.file(File(widget.imageFile.path)),
        ),
        TextFormField(
          controller: labelController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Label",
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(labelController.text);
              },
              child: const Text("Process"),
            ),
          ],
        ),
      ],
    );
  }
}
