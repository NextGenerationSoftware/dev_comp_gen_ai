import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/own_notifications_repository.dart';
import 'package:flutter/material.dart';

class NewNotificationOverlay1 extends StatelessWidget {
  final NotificationData notificationData;
  final Function() onDetails;
  const NewNotificationOverlay1(
      {super.key, required this.notificationData, required this.onDetails});

  Future displayDetails(
      BuildContext context, NotificationData notificationData) async {
    // display the details of the notification
    onDetails();
    OwnNotificationsRepository().displayDetails(context, notificationData);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          child: SizedBox(
            width: GlobalVariables.screenSize.width * 0.4,
            child: GestureDetector(
              onTap: () {
                displayDetails(context, notificationData);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationData.headline ?? "-",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //Text(notificationData.text ?? "-"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
