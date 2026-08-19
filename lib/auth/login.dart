import 'package:flutter/material.dart';
import 'package:foodie/auth/signup.dart';
import 'package:foodie/features/welcome/welcome_screen.dart';
import 'package:foodie/utils/main_button.dart';
import 'package:foodie/utils/social_icon_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:foodie/features/splash/presentation/widgets/decorative_circles.dart';
import 'package:foodie/utils/custom_input_box.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const WelcomeScreen()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            const DecorativeCircles(),
            SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 220),
                      _fieldLabel('Email Address'),
                      CustomInputbox(
                        controller: _email,
                        hintText: 'Enter your email here',
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 26),
                      _fieldLabel('Password'),
                      CustomInputbox(
                        controller: _password,
                        hintText: 'Enter your password here',
                        obscureText: true,
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 51),
                      Mainbutton(text: 'Login', onPressed: _onLoginPressed),
                      const SizedBox(height: 54),
                      _buildOrDivider(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialIconButton(
                            icon: 'assets/icons/google.svg',
                            onTap: () {},
                          ),
                          const SizedBox(width: 20),
                          SocialIconButton(
                            icon: 'assets/icons/facebook.svg',
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text( "Don't have any account?  ",
                              style: GoogleFonts.inter(fontSize: 14,color: AppColors.textDark,fontWeight: FontWeight.w300),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Signup()));
                              },
                              child: Text( 'Sign Up',
                                style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w600,color: Color(0xFFBA1306),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 140),
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }

   Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 12),
      child: Text( text,
        style: GoogleFonts.inter(fontSize: 15,fontWeight: FontWeight.w400,color: AppColors.textDark,),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.textDark)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('or',
              style: GoogleFonts.inter(color: AppColors.textDark, fontSize: 20,fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(child: Divider(color: AppColors.textDark)),
      
        ],
      ),
    );
  }
}
