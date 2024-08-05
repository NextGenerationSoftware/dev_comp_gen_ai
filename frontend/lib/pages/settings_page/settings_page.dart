import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/pages/landing_page/landing_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/settings_page/widgets/settings_page_header.dart';
import 'package:dev_comp_gen_ai_frontend/pages/tutorial_page/tutorial_page.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_button_1.dart';

class SettingsPage extends StatefulWidget {
  static const route = "/settings";
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController nameController =
      TextEditingController(text: GlobalVariables.userData!.name);

  bool checkForChanges() {
    bool changes = false;
    if (GlobalVariables.userData!.name != nameController.text) {
      changes = true;
    }
    return changes;
  }

  signOut() {
    GlobalFunctions.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LandingPage.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton1(
                    height: 35,
                    width: double.maxFinite,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pushNamed(TutorialPage.route);
                    },
                    child: const Text(
                      "Tutorial",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  checkForChanges()
                      ? CustomButton1(
                          width: double.maxFinite,
                          onPressed: () async {
                            GlobalVariables.userData!.name =
                                nameController.text;
                            await FirestoreRepository.updateUserData();
                            setState(() {});
                          },
                          color: Colors.black,
                          child: const Text("Save changes",
                              style: TextStyle(color: Colors.white)),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: const Text(
                      "Sign out",
                      style: TextStyle(
                          fontSize: 16, color: GlobalColors.highlight3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
