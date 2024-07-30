import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:flutter/material.dart';

class PopupFrame1 extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  const PopupFrame1(
      {super.key,
      this.child,
      this.padding,
      this.margin,
      this.borderRadius,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: MediaQuery.of(context).viewInsets +
                (margin ?? const EdgeInsets.all(10)),
            padding: padding ?? const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(15),
                color: backgroundColor ?? GlobalColors.background1),
            child: Material(
                color: Colors.transparent, child: child ?? const SizedBox()),
          ),
        ),
      ],
    );
  }
}
