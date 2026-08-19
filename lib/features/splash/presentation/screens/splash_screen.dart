import 'package:flutter/material.dart';
import 'package:foodie/auth/login.dart';
import 'package:foodie/core/theme/app_colors.dart';
import 'package:foodie/features/splash/presentation/widgets/circular_icon_loader.dart';
import 'package:foodie/features/splash/presentation/widgets/logo_view.dart';
import 'package:foodie/features/splash/presentation/widgets/tagline_view.dart';

enum _SplashStage { loader, tagline, logo }

/// Full intro sequence:
/// 1. Orange circular loader (anti-clockwise orbiting icons)
/// 2. "Enjoy it!" tagline screen
/// 3. Logo reveal screen
/// Then auto-navigates to [Login].
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashStage _stage = _SplashStage.loader;

  // Tune these to match the exact timing from your Figma prototype.
  static const _loaderDuration = Duration(seconds: 3);
  // static const _taglineDuration = Duration(seconds: 2);
  static const _logoDuration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(_loaderDuration);
    if (!mounted) return;
    // setState(() => _stage = _SplashStage.tagline);

    // await Future.delayed(_taglineDuration);
    // if (!mounted) return;
    setState(() => _stage = _SplashStage.logo);

    await Future.delayed(_logoDuration);
    if (!mounted) return;
    _goToWelcome();
  }

  void _goToWelcome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, _) => const Login(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

@override
Widget build(BuildContext context) {
  final bool isLoaderStage = _stage == _SplashStage.loader;

  return Scaffold(
    backgroundColor: isLoaderStage ? AppColors.primary : AppColors.background,
    body: AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _buildStage(),
    ),
  );
}

  Widget _buildStage() {
    switch (_stage) {
      case _SplashStage.loader:
        return Center(
          key: const ValueKey('loader'),
          child: const CircularIconLoader(),
        );
      case _SplashStage.tagline:
        return const TaglineView(key: ValueKey('tagline'));
      case _SplashStage.logo:
        return const LogoView(key: ValueKey('logo'));
    }
  }
}
