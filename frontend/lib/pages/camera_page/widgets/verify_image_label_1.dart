import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/custom_button_1.dart';
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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: GlobalVariables.screenSize.height * 0.2),
            child: Image.file(File(widget.imageFile.path), fit: BoxFit.contain),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: labelController,
          minLines: 1,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Verify the label or label in your own words",
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            CustomButton1(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              color: Colors.red,
              child: const Text(
                "Proceed without label",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            CustomButton1(
              onPressed: () {
                Navigator.of(context).pop(labelController.text);
              },
              color: Colors.black,
              child: const Text(
                "Proceed",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
