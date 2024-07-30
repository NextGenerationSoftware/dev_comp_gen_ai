import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:flutter/material.dart';

class OwnNotificationsRepository {
  Future displayDetails(
      BuildContext context, NotificationData notificationData) async {
    // display the details of the notification
    GlobalFunctions.launchPopup1(
        context: context,
        child: Column(
          children: [
            //TODO: make notifications look nice
            Text(notificationData.text ?? "-"),
            Text(notificationData.text ?? "-"),
            Text(notificationData.text ?? "-"),
          ],
        ));
  }
}
