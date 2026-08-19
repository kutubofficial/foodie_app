import 'package:flutter/material.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:foodie/features/splash/presentation/widgets/decorative_circles.dart';
import 'package:foodie/home/home_wrapper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen>createState()=>_WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>{

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),(){
      if(!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const HomeWrapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const DecorativeCircles(),
           Center(
               child :const Text("Welcome",
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600,color: Color(0xFFD94914),),
                ),
            ),
        ],
      ),
    );
  }
}
