import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
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
            color: Colors.black.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "CrowdData",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 40,
                  child: IconButton(
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).pushNamed(CameraPage.route);
                    },
                    color: Colors.black,
                    icon: const Icon(
                      Icons.play_arrow,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Let's get data",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
