import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/custom_button_1.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/tutorial_page/tutorial_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static const route = "/";
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/landing_page_1_min.jpeg",
          width: GlobalVariables.screenSize.width,
          height: GlobalVariables.screenSize.height,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: GlobalVariables.screenSize.width,
          child: Container(
            color: Colors.black.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "CrowdData",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).pushNamed(CameraPage.route);
                    },
                    highlightColor: Colors.orangeAccent,
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Let's get data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomButton1(
              width: 170,
              height: 30,
              color: Colors.white.withAlpha(130),
              onPressed: () {
                Navigator.of(context).pushNamed(TutorialPage.route);
              },
              child: const Text(
                "Tutorial",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
