import 'dart:math';

import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CongratulationPopup1 extends StatefulWidget {
  final int points;
  const CongratulationPopup1({
    super.key,
    required this.points,
  });

  @override
  State<CongratulationPopup1> createState() => _CongratulationPopup1State();
}

class _CongratulationPopup1State extends State<CongratulationPopup1> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConfettiWidget(
          confettiController: confettiController,
          blastDirection: pi / 2,
          emissionFrequency: 1,
          gravity: 1,
          shouldLoop: true,
          colors: const [Colors.green, Colors.blue, Colors.pink],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.points.toString()),
            const Icon(
              Icons.star,
              color: GlobalColors.highlight4,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text("congratulation"),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Next"))
      ],
    );
  }
}
