import 'package:dev_comp_gen_ai_frontend/core/data_models/notification_data.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/own_notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    List<NotificationData> notificationData =
        GlobalVariables.notificationData.reversed.toList();
    return Positioned(
      bottom: 100,
      left: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxHeight: GlobalVariables.screenSize.height * 0.5,
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
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: notificationData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            displayDetails(context, notificationData[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notificationData[index].headline ?? "-",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateFormat(GlobalVariables.timeFormat).format(
                                      notificationData[index].timestamp ??
                                          DateTime.now()),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: GlobalColors.darkGrey1),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (index > 0) const Divider(),
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
