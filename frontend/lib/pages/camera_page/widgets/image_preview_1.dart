import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/storage_repository.dart';
import 'package:flutter/material.dart';

class ImagePreview1 extends StatefulWidget {
  final XFile imageFile;
  final String path;
  const ImagePreview1({
    super.key,
    required this.imageFile,
    required this.path,
  });

  @override
  State<ImagePreview1> createState() => _ImagePreview1State();
}

class _ImagePreview1State extends State<ImagePreview1> {
  bool loading = false;

  Future proceedImage() async {
    setState(() {
      loading = true;
    });
    try {
      // convert image
      Uint8List imageByteList = await widget.imageFile.readAsBytes();
      // upload image to storage and get url

      String? url =
          await StorageRepository.uploadAndGetUrl(imageByteList, widget.path);
      Navigator.of(context).pop(url);
    } catch (e) {
      log(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Image.file(File(widget.imageFile.path)),
        ),
        loading
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      proceedImage();
                    },
                    child: const Text("Process"),
                  ),
                ],
              ),
      ],
    );
  }
}
