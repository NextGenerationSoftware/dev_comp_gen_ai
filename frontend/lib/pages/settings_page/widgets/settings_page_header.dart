import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
import 'package:flutter/material.dart';

class SettingsPageHeader extends StatelessWidget {
  const SettingsPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CameraPage.route);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "Settings",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
