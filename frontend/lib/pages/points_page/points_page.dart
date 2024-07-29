import 'package:dev_comp_gen_ai_frontend/pages/points_page/widgets/points_page_header.dart';
import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  static const route = "/points";
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PointsPageHeader(),
        ],
      ),
    );
  }
}
