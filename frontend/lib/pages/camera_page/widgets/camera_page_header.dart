import 'package:dev_comp_gen_ai_frontend/pages/points_page/points_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

class CameraPageHeader extends StatelessWidget {
  const CameraPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              child: /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ShopPage.route);
                  },
                  icon: const Icon(
                    Icons.shop,
                    size: 30,
                  ),
                ),
              ],
            ),*/
                  SizedBox()),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(PointsPage.route);
            },
            child: const Text(
              "Points",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsPage.route);
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
