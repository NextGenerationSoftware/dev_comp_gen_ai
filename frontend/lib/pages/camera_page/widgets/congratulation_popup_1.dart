import 'dart:math';

import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/custom_button_1.dart';
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
          blastDirection: 0, //pi / 2,
          emissionFrequency: 0.01,
          gravity: 0.2,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          colors: const [Colors.green, Colors.blue, Colors.pink],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.points.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Icon(
              Icons.star,
              color: GlobalColors.highlight2,
              size: 30,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Thank you 😊\nfor your contribution",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton1(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.black,
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
