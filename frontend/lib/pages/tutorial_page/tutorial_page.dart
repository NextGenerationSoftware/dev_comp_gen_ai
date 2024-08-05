import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialPage extends StatelessWidget {
  static const route = "/tutorial";
  const TutorialPage({super.key});

  final textStyle1 = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  final textStyle2 = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  final textStyle3 = const TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    final imageWidth = GlobalVariables.screenSize.width * 0.28;
    const spacing1 = 50.0;
    const spacing2 = 15.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("How does it work?", style: textStyle1)),
                  const SizedBox(
                    height: spacing1,
                  ),
                  Text("1. Check whats interesting", style: textStyle2),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/tutorial/tutorial_datarequired.png",
                        width: imageWidth,
                      ),
                      Image.asset(
                        "assets/images/tutorial/tutorial_notifications.png",
                        width: imageWidth,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Text(
                      "Find out which opjects are important to capture in images with the information button on the right. Or just move your phone around slowly to scan your surroundings and get notifications for objects that are important to capture.",
                      style: textStyle3),
                  const SizedBox(
                    height: spacing1,
                  ),
                  Text("2. Take a picture", style: textStyle2),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/tutorial/tutorial_caputre.png",
                        width: imageWidth,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Text(
                      "When you found an object, take a picture of it. Then give the AI some time to process the image and calculate the points you get for it.",
                      style: textStyle3),
                  const SizedBox(
                    height: spacing1,
                  ),
                  Text("3. Label it", style: textStyle2),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/tutorial/tutorial_label.png",
                        width: imageWidth,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Text(
                      "Give it a label to help the AI learn better. Just describe as long or short you want what the object on the picture is.",
                      style: textStyle3),
                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 100,
                  ),
                  Center(child: Text("Points", style: textStyle1)),
                  const SizedBox(
                    height: spacing1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/tutorial/tutorial_points.png",
                        width: imageWidth,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: spacing2,
                  ),
                  Text("You collect points for the objects you capture.",
                      style: textStyle3),
                  Text(
                      "Find out what you can do with them on our website crowddata.tech",
                      style: textStyle3),
                  const SizedBox(
                    height: spacing1,
                  ),
                  CustomButton1(
                    width: double.maxFinite,
                    color: Colors.black,
                    onPressed: () async {
                      await launchUrl(Uri.parse("https://crowddata.tech"));
                    },
                    child: const Text(
                      "visit crowddata.tech",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: spacing1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
