import 'package:dev_comp_gen_ai_frontend/core/repositories/backend_repository.dart';
import 'package:flutter/material.dart';

class ImageEvaluated1 extends StatefulWidget {
  final String imageUrl;
  final String imageId;
  const ImageEvaluated1({
    super.key,
    required this.imageUrl,
    required this.imageId,
  });

  @override
  State<ImageEvaluated1> createState() => _ImageEvaluated1State();
}

class _ImageEvaluated1State extends State<ImageEvaluated1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // run after first build
      BackendRepository()
          .backendImageEvaluation(widget.imageUrl, widget.imageId)
          .then((value) {
        Navigator.of(context).pop(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
