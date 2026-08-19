import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIconButton extends StatefulWidget {
  final String icon;
  final VoidCallback onTap;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: const Color.fromARGB(255, 219, 24, 24)),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(4, 4),
          ),
        ],
        ),
        child: Center(
          child: SvgPicture.asset(widget.icon, width: 32, height: 32,),
        ),
      ),
    );
  }
}