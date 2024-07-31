import 'package:camera/camera.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_datarequired.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_global.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_user.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/point_stats_data.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static Size screenSize = const Size(0, 0);
  static String? currentRoute;

  static String DEVUSERID = "0IgcJMTOZwXmkDvbis5EEOBueEs1";

  static DBUser? userData;
  static DBGlobal? globalData;
  static Map<DateTime, List<DBDatarequired>> datarequiredMap =
      {}; // key: timestamp of last fetch, value: list of datarequired
  static List<NotificationData> notificationData =
      []; // list of the most recent notifications
  static PointStatsData? pointStatsData; // point statistics

  static List<CameraDescription> cameraDescriptions = [];

  static String dateAndTimeFormat = "dd.MM.yyyy HH:mm";
  static String timeFormat = "HH:mm:ss";
}
