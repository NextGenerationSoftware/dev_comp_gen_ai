import 'dart:developer';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/loading_page_1.dart';
import 'package:flutter/material.dart';

class UserDataWrapper extends StatefulWidget {
  // fetch userData if not already available

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
      // run after first build
      if (GlobalVariables.userData == null) {
        await FirestoreRepository.getUserData().then((value) async {
          if (value == null) {
            // redirect to finish sign up page if no user data entry is in the database (happens when the user signs up via Social Media Logins)
            log("Error fetching user data from DB");
          } else {
            // everything is ok and the user data is successfully fetched from the DB
            GlobalVariables.userData = value;
            setState(() {
              loading = false;
            });
          }
        });
      } else {
        setState(() {
          loading = false;
        });
      }
      /*if (mounted) {
        // listen to DB changes for this user
        // cancel and reload the listener for this page so the listener doesn't get duplicated
        if (FirestoreRepository.userDataListener != null) {
          FirestoreRepository.userDataListener!.cancel();
          FirestoreRepository.userDataListener = null;
        }
        FirestoreRepository.userDataListener ??= FirebaseFirestore.instance
            .collection("USERS")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .listen(
          (event) {
            final data = event.data();
            log("User Data listener: $data");
            if (data != null) {
              GlobalVariables.userData = DBUser.fromJson(data);
              context.read<UserDataProvider>().set(GlobalVariables.userData!);
            }
          },
          onError: (e) {
            log("User Data listener failed: $e");
          },
        );
      }*/
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
