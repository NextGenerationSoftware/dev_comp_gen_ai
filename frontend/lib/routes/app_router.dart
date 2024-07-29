import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/core/wrapper/global_data_wrapper.dart';
import 'package:dev_comp_gen_ai_frontend/core/wrapper/user_data_wrapper.dart';
import 'package:dev_comp_gen_ai_frontend/pages/camera_page/camera_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/landing_page/landing_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/points_page/points_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/settings_page/settings_page.dart';
import 'package:dev_comp_gen_ai_frontend/pages/shop_page/shop_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    // save current route name as global variable to use it in other parts of the app
    GlobalVariables.currentRoute = routeSettings.name;
    switch (routeSettings.name) {
      case LandingPage.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const LandingPage(),
        );
      case CameraPage.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const CameraPage(),
        );
      case SettingsPage.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const SettingsPage(),
        );
      case PointsPage.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const PointsPage(),
        );
      case ShopPage.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const ShopPage(),
        );
      default:
        return CustomPageRoute1(
          safeArea: true,
          child: const LandingPage(),
        );
    }
  }
}

class CustomPageRoute1 extends MaterialPageRoute {
  // a custom route animation with a Scaffold and SafeArea on top
  // including a wrapper for globalData
  final Widget child;
  final bool safeArea;

  CustomPageRoute1({required this.child, required this.safeArea})
      : super(
          builder: (context) {
            return child;
          },
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: Scaffold(
        body: GlobalDataWrapper(
          child: UserDataWrapper(
            child: safeArea
                ? SafeArea(
                    child: Container(
                      width: GlobalVariables.screenSize.width,
                      height: GlobalVariables.screenSize.height,
                      color: GlobalColors.background1,
                      child: child,
                    ),
                  )
                : Container(
                    width: GlobalVariables.screenSize.width,
                    height: GlobalVariables.screenSize.height,
                    color: GlobalColors.background1,
                    child: child,
                  ),
          ),
        ),
      ),
    );
  }
}
