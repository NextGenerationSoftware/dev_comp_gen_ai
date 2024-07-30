import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/repositories/firestore_repository.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/error_page_1.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/error_page_2.dart';
import 'package:dev_comp_gen_ai_frontend/core/widgets/loading_page_1.dart';
import 'package:flutter/material.dart';

class GlobalDataWrapper extends StatefulWidget {
  final Widget child;
  const GlobalDataWrapper({super.key, required this.child});

  @override
  State<GlobalDataWrapper> createState() => _GlobalDataWrapperState();
}

class _GlobalDataWrapperState extends State<GlobalDataWrapper> {
  bool loading = true;
  bool internetError = false;
  bool globalDataError = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // run after first build
      // get global data
      if (GlobalVariables.globalData == null) {
        FirestoreRepository.getGlobalData().then((value) {
          if (value == null) {
            if (mounted) {
              setState(() {
                globalDataError = true;
              });
            }
          } else {
            GlobalVariables.globalData = value;
            if (mounted) {
              setState(() {
                loading = false;
              });
            }
          }
        });
      } else {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return internetError
        ? const ErrorPage1()
        : globalDataError
            ? const ErrorPage2()
            : (loading ? const LoadingPage1() : widget.child);
  }
}
