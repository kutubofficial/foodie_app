import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.background,
      color: const Color.fromARGB(255, 251, 250, 250),
      child: Center(
        child: Image.asset('assets/icons/title_img.png')
      ),
    );
  }
}
