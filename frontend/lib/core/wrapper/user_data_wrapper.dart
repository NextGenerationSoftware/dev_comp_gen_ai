import 'package:dev_comp_gen_ai_frontend/core/global_functions.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/loading_page_1.dart';
import 'package:flutter/material.dart';

class UserDataWrapper extends StatefulWidget {
  // fetch userData if not already available
  // fetch and calculate points initally

  final Widget child;
  const UserDataWrapper({super.key, required this.child});

  @override
  State<UserDataWrapper> createState() => _UserDataWrapperState();
}

class _UserDataWrapperState extends State<UserDataWrapper> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool success = true;
      // run after first build
      if (GlobalVariables.userData == null) {
        await FirestoreRepository.getUserData().then((value) async {
          if (value == null) {
            // redirect to finish sign up page if no user data entry is in the database (happens when the user signs up via Social Media Logins)
            GlobalFunctions.showInfo1(
                context: context, message: "Error fetching user data from DB");
            success = false;
          } else {
            // everything is ok and the user data is successfully fetched from the DB
            GlobalVariables.userData = value;
          }
        });
      }
      if (GlobalVariables.pointStatsData == null) {
        await GlobalFunctions.getPointStats().then((value) {
          if (value == null) {
            GlobalFunctions.showInfo1(
                context: context,
                message: "Error fetching points data from DB");
            success = false;
          } else {
            GlobalVariables.pointStatsData = value;
          }
        });
      }
      if (success) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const LoadingPage1() : widget.child;
  }
}
