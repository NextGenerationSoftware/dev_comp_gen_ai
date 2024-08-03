import 'dart:ui';

import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/pages/points_page/widgets/points_page_header.dart';
import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  static const route = "/points";
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int totalPoints = GlobalVariables.pointStatsData!.totalPoints ?? 0;
    final int spentPoints = GlobalVariables.userData!.pointsspent ?? 0;
    final int availablePoints = totalPoints - spentPoints;
    final int totalImages = GlobalVariables.pointStatsData!.totalImages ?? 0;

    return Column(
      children: [
        const PointsPageHeader(),
        Expanded(
          child: PointsPageBackground1(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              totalPoints.toString(),
                              style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.star,
                              color: GlobalColors.highlight4,
                              size: 30,
                            )
                          ],
                        ),
                        const Text(
                          "Total Points",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  availablePoints.toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const Text(
                                  "available",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  spentPoints.toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const Text(
                                  "spent",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Row(
                      children: [
                        const Text(
                          "Total Images",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          totalImages.toString(),
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PointsPageBackground1 extends StatelessWidget {
  final Widget child;
  const PointsPageBackground1({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double size1 = GlobalVariables.screenSize.width * 1.4;
    return ClipRRect(
      child: Container(
        decoration: const BoxDecoration(
          color: GlobalColors.background1,
        ),
        child: Stack(
          children: [
            Positioned(
              top: -size1 / 2,
              left: -size1 / 2,
              child: Container(
                width: size1,
                height: size1,
                decoration: BoxDecoration(
                  color: GlobalColors.highlight3.withAlpha(100),
                  borderRadius: BorderRadius.circular(999999),
                ),
              ),
            ),
            Positioned(
              bottom: -size1 / 2,
              right: -size1 / 2,
              child: Container(
                width: size1,
                height: size1,
                decoration: BoxDecoration(
                  color: GlobalColors.highlight4.withAlpha(100),
                  borderRadius: BorderRadius.circular(999999),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
