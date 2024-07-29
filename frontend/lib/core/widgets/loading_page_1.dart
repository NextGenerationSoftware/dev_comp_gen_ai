import 'package:flutter/material.dart';

class LoadingPage1 extends StatelessWidget {
  const LoadingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
