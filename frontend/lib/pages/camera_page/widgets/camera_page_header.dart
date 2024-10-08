import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/pages/points_page/points_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/settings_page/settings_page.dart';
import 'package:flutter/material.dart';

class CameraPageHeader extends StatelessWidget {
  final Function() onClicked;
  const CameraPageHeader({super.key, required this.onClicked});

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
              onClicked();
              Navigator.of(context).pushNamed(PointsPage.route);
            },
            child: Row(
              children: [
                Text(
                  ((GlobalVariables.pointStatsData!.totalPoints ?? 0) -
                          (GlobalVariables.userData!.pointsspent ?? 0))
                      .toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Icon(
                  Icons.star,
                  color: GlobalColors.highlight4,
                  size: 20,
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    onClicked();
                    Navigator.of(context).pushNamed(SettingsPage.route);
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.white,
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
