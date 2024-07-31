import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/own_notifications_repository.dart';
import 'package:flutter/material.dart';

class NotificationHistoryOverlay1 extends StatelessWidget {
  // display the notifications history
  final Function() onDetails;
  const NotificationHistoryOverlay1({super.key, required this.onDetails});

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
          child: GlobalVariables.notificationData.isEmpty
              ? const Text("No notifications")
              : SizedBox(
                  width: GlobalVariables.screenSize.width * 0.4,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: GlobalVariables.notificationData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            displayDetails(context,
                                GlobalVariables.notificationData[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  GlobalVariables
                                          .notificationData[index].headline ??
                                      "-",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                /*Text(GlobalVariables
                                        .notificationData[index].text ??
                                    "-"),*/
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
