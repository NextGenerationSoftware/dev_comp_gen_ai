import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_datarequired.dart';
import 'package:dev_comp_gen_ai_frontend/core/data_models/db_datataken.dart';
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

  static Future<List<DBDatarequired>> getDatarequiredList(
      {String? offsetId, int resultLimit = 100}) async {
    List<DBDatarequired> datarequiredList = [];
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots = [];
      if (offsetId == null) {
        snapshots = (await FirebaseFirestore.instance
                .collection("DATAREQUIRED")
                .orderBy("id")
                .limit(resultLimit)
                .get())
            .docs;
      } else {
        snapshots = (await FirebaseFirestore.instance
                .collection("DATAREQUIRED")
                .orderBy("id")
                .startAfter([offsetId])
                .limit(resultLimit)
                .get())
            .docs;
      }
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in snapshots) {
        try {
          datarequiredList.add(DBDatarequired.fromJson(element.data()));
        } catch (e) {
          log(e.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return datarequiredList;
  }

  static Future<List<DBDatataken>> getDatatakenList(
      {String? offsetId, int resultLimit = 100}) async {
    List<DBDatataken> datarequiredList = [];
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots = [];
      if (offsetId == null) {
        snapshots = (await FirebaseFirestore.instance
                .collection("DATATAKEN")
                .orderBy("id")
                .where("userid", isEqualTo: GlobalVariables.DEVUSERID)
                .limit(resultLimit)
                .get())
            .docs;
      } else {
        snapshots = (await FirebaseFirestore.instance
                .collection("DATATAKEN")
                .orderBy("id")
                .startAfter([offsetId])
                .where("userid", isEqualTo: GlobalVariables.DEVUSERID)
                .limit(resultLimit)
                .get())
            .docs;
      }
      for (QueryDocumentSnapshot<Map<String, dynamic>> element in snapshots) {
        try {
          datarequiredList.add(DBDatataken.fromJson(element.data()));
        } catch (e) {
          log(e.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return datarequiredList;
  }
}
