import 'package:dev_comp_gen_ai_frontend/core/global_colors.dart';
import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  final Color? color;
  final double width;
  final double height;
  final WidgetStatePropertyAll<double?>? elevation;
  final Gradient? gradient;
  final bool onlyBorder;
  const CustomButton1({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.width = 300,
    this.height = 40,
    this.elevation,
    this.gradient,
    this.onlyBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        /*margin: onlyBorder || gradient != null
            ? const EdgeInsets.fromLTRB(0, 4, 0, 4)
            : null,*/
        height: height, // onlyBorder || gradient != null ? height : null,
        decoration: BoxDecoration(
            border: onlyBorder
                ? Border.all(width: 3, color: color ?? Colors.black)
                : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(99999)),
        child: ElevatedButton(
          style: ButtonStyle(
              visualDensity: gradient != null ? VisualDensity.compact : null,
              elevation: elevation ?? const WidgetStatePropertyAll(0),
              shadowColor:
                  const WidgetStatePropertyAll(GlobalColors.lightGrey1),
              backgroundColor: WidgetStatePropertyAll(
                  gradient != null || onlyBorder ? Colors.transparent : color),
              foregroundColor: const WidgetStatePropertyAll(
                  Colors.black), // to make text black by default
              fixedSize: WidgetStatePropertyAll(Size(width, height))),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
