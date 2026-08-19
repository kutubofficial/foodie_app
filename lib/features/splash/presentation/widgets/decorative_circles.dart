import 'package:flutter/material.dart';
import 'package:foodie/core/theme/app_colors.dart';

/// The soft peach quarter-circles pinned to opposite corners,
/// reused on both the "Enjoy it!" and Welcome screens.
class DecorativeCircles extends StatelessWidget {
  const DecorativeCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -141,
          left: -161,
          child: _circle(322,334, AppColors.primaryDark),
        ),
        Positioned(
          bottom: -141,
          right: -161,
          child: _circle(322,334, AppColors.primaryDark),
        ),
      ],
    );
  }

  Widget _circle(double heightSize, double widthSize, Color color) {
    return Container(
      width: widthSize,
      height: heightSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
