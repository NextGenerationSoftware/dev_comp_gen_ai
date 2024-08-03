import 'package:dev_comp_gen_ai_frontend/core/repositories/backend_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/custom_button_1.dart';
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
        if (mounted) {
          Navigator.of(context).pop(value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Evaluating Image...",
          style: TextStyle(fontSize: 18),
        ),
        CustomButton1(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          color: Colors.red,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
