import 'package:camera/camera.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_global.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_user.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static Size screenSize = const Size(0, 0);
  static String? currentRoute;

  static String DEVUSERID = "0IgcJMTOZwXmkDvbis5EEOBueEs1";

  static DBUser? userData;
  static DBGlobal? globalData;

  static List<CameraDescription> cameraDescriptions = [];
}
