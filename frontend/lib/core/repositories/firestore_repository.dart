import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_global.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_user.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';

class FirestoreRepository {
  static Future<DBGlobal?> getGlobalData() async {
    // fetch all data from the GLOBAL collection
    DBGlobal? globalData;
    try {
      Map<String, dynamic>? dbData = (await FirebaseFirestore.instance
              .collection("GLOBAL")
              .doc("global")
              .get())
          .data();
      if (dbData != null) {
        globalData = DBGlobal();
        globalData.global = DBGlobalGlobal.fromJson(dbData);
      }
    } catch (e) {
      log(e.toString());
    }
    return globalData;
  }

  static Future<DBUser?> getUserData({String? uid}) async {
    // fetch user data for the given uid
    // if no uid is given then use the logged in user
    DBUser? userData;
    try {
      Map<String, dynamic>? dbData = (await FirebaseFirestore.instance
              .collection("USER")
              .doc(uid ?? GlobalVariables.DEVUSERID)
              .get())
          .data();
      if (dbData != null) {
        userData = DBUser.fromJson(dbData);
      }
    } catch (e) {
      log(e.toString());
    }
    return userData;
  }

  static Future<bool> updateUserData({String? uid, DBUser? userData}) async {
    // updates user data for the given uid
    // if no uid is given then use the logged in user
    bool success = false;
    try {
      await FirebaseFirestore.instance
          .collection("USER")
          .doc(uid ?? GlobalVariables.DEVUSERID)
          .update((userData ?? GlobalVariables.userData!).toMap());
      success = true;
    } catch (e) {
      log(e.toString());
      success = false;
    }
    return success;
  }
}
