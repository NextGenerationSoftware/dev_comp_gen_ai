import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/pages/landing_page/landing_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/settings_page/widgets/settings_page_header.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsPageHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    height: 10,
                  ),
                  checkForChanges()
                      ? ElevatedButton(
                          onPressed: () async {
                            GlobalVariables.userData!.name =
                                nameController.text;
                            await FirestoreRepository.updateUserData();
                          },
                          child: const Text("Save changes"),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LandingPage.route, (route) => false);
                    },
                    child: const Text(
                      "Sign out",
                      style: TextStyle(fontSize: 16),
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
