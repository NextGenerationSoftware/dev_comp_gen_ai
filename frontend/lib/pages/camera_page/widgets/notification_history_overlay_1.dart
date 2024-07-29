import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class NotificationHistoryOverlay1 extends StatefulWidget {
  // display the notifications history
  const NotificationHistoryOverlay1({super.key});

  @override
  State<NotificationHistoryOverlay1> createState() =>
      _NotificationHistoryOverlay1State();
}

class _NotificationHistoryOverlay1State
    extends State<NotificationHistoryOverlay1> {
  @override
  void initState() {
    super.initState();
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
                        return Padding(
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
                              Text(GlobalVariables
                                      .notificationData[index].text ??
                                  "-"),
                            ],
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
