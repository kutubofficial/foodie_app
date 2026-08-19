import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mainbutton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isLoading;

  const Mainbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 180,
    this.height = 60,
    // this.backgroundColor = const Color(0xFFF95F26),
    this.backgroundColor = const Color(0xFFFF6B35),
    this.textColor = Colors.white,
    this.borderRadius = 20,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            elevation: 8,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius),),
            textStyle: TextStyle(fontSize: fontSize,fontWeight: fontWeight,letterSpacing: 0.5,),
          ),
          child: isLoading
              ? const SizedBox(width: 22,height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5,color: Colors.white,),)
                : Text(text,style: GoogleFonts.inter(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.white),),
        ),
      ),
    );
  }
}