import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArcoreView1 extends StatelessWidget {
  ArcoreView1({super.key});

  // This is used in the platform side to register the view.
  final String viewType = 'ar-core-view-android';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(30),
      child: AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
