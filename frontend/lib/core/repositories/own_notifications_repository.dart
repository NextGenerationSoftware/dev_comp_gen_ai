import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:flutter/material.dart';

class OwnNotificationsRepository {
  Future displayDetails(
      BuildContext context, NotificationData notificationData) async {
    // display the details of the notification
    GlobalFunctions.launchPopup1(
        context: context,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationData.headline ?? "-",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                notificationData.text ?? "-",
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
