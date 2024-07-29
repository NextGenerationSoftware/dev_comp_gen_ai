import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const route = "/";
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Name of the App",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CameraPage.route);
          },
          icon: const Icon(
            Icons.play_arrow,
            size: 50,
          ),
        ),
        const Text("Let's go"),
      ],
    );
  }
}
