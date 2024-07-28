import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:dev_comp_gen_ai_frontend/core/global_variables.dart';
import 'package:dev_comp_gen_ai_frontend/pages/ar_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    // save current route name as global variable to use it in other parts of the app
    GlobalVariables.currentRoute = routeSettings.name;
    switch (routeSettings.name) {
      case ArPage.route:
        return CustomPageRoute1(
          safeArea: false,
          child: ArPage(),
        );
      /*case SignIn.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const SignIn(),
        );
      case SignUp.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const SignUp(),
        );
      case FinishSignUp.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const FinishSignUp(),
        );
      case MainUserMenu.route:
        return CustomPageRoute1(
          safeArea: true,
          child: const UserDataWrapper(child: MainUserMenu()),
        );*/
      default:
        return CustomPageRoute1(
          safeArea: true,
          child: ArPage(),
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
          child: safeArea
              ? SafeArea(
                  child: Container(
                    color: GlobalColors.background1,
                    child: child,
                  ),
                )
              : Container(
                  color: GlobalColors.background1,
                  child: child,
                ),
        ),
      ),
    );
  }
}
