import 'package:flutter/material.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'decorative_circles.dart';

class TaglineView extends StatelessWidget {
  const TaglineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Stack(
        children: [
          const DecorativeCircles(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Fastest delivery right next to your door',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.textDarkGrey,),
                  ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                  'Enjoy it!',
                  style: TextStyle(fontSize: 32,fontWeight: FontWeight.w600,color: AppColors.primary,),
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
