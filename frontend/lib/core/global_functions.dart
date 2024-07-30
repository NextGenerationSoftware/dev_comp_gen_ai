import 'dart:developer';

import 'package:dev_comp_gen_ai_frontend/core/data_models/db_datataken.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/point_stats_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/popup_frame_1.dart';
import 'package:flutter/material.dart';

class GlobalFunctions {
  static showInfo1({required BuildContext context, required String message}) {
    // show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static Future<dynamic> launchPopup1({
    Widget? child,
    required BuildContext context,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    final Color? backgroundColor,
  }) async {
    dynamic retVal;
    await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return PopupFrame1(
            padding: padding,
            margin: margin,
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            child: child,
          );
        }).then((value) {
      retVal = value;
    });
    return retVal;
  }

  static dismissKeyboard() {
    // dismiss the keyboard and remove the focus from the text field when clicking anywhere
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static int? pointcatToPoints(int? pointcat) {
    int? points;
    if (GlobalVariables.globalData != null) {
      try {
        points =
            GlobalVariables.globalData!.global!.pointcats.firstWhere((element) {
          return element.c == pointcat;
        }).p;
      } catch (e) {
        log(e.toString());
      }
    }
    return points;
  }

  static Future<PointStatsData?> getPointStats() async {
    PointStatsData? pointStatsData =
        PointStatsData(totalImages: 0, totalPoints: 0);
    try {
      List<DBDatataken> dbDatataken =
          await FirestoreRepository.getDatatakenList();
      for (var element in dbDatataken) {
        pointStatsData.totalPoints =
            pointStatsData.totalPoints! + (element.points ?? 0);
        pointStatsData.totalImages = pointStatsData.totalImages! + 1;
      }
    } catch (e) {
      log(e.toString());
      pointStatsData = null;
    }

    return pointStatsData;
  }

  static signOut() {
    // sign out the user
    GlobalVariables.userData = null;
    GlobalVariables.globalData = null;
    GlobalVariables.datarequiredMap = {};
    GlobalVariables.notificationData = [];
    GlobalVariables.pointStatsData = null;
  }

  static String createUid() {
    // create an uid from timestamp
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
