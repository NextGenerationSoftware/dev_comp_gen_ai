import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
import 'package:flutter/material.dart';

class PointsPageHeader extends StatelessWidget {
  const PointsPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ),
                ),
              ],
            ),
          ),
          /*const Text(
            "Points",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),*/
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
