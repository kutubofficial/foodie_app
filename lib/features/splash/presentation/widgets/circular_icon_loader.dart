import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIconLoader extends StatefulWidget {
  const CircularIconLoader({
    super.key,
    this.radius = 70,
    this.iconSize = 32,
    this.orbitDuration = const Duration(seconds: 4),
  });

  final double radius;
  final double iconSize;
  final Duration orbitDuration;

  @override
  State<CircularIconLoader> createState() => _CircularIconLoaderState();
}

class _CircularIconLoaderState extends State<CircularIconLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const List<String> _orbitIcons = [
    'assets/icons/splash_5.svg',
    'assets/icons/splash_1.svg',
    'assets/icons/splsh_4.svg',
    'assets/icons/splash_3.svg',
    'assets/icons/splash_2.svg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.orbitDuration,)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double boxSize = widget.radius * 2 + widget.iconSize + 24;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // Negative sign = anti-clockwise rotation.
        final double baseAngle = -_controller.value * 2 * math.pi;

        return SizedBox(
          width: boxSize,
          height: boxSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              for (int i = 0; i < _orbitIcons.length; i++)
                _OrbitingIcon(
                  icon: _orbitIcons[i],
                  angle: baseAngle + (2 * math.pi / _orbitIcons.length) * i,
                  radius: widget.radius,
                  iconSize: widget.iconSize,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _OrbitingIcon extends StatelessWidget {
  const _OrbitingIcon({
    required this.icon,
    required this.angle,
    required this.radius,
    required this.iconSize,
  });

  final String icon;
  final double angle;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final double dx = radius * math.cos(angle);
    final double dy = radius * math.sin(angle);

    return Transform.translate(
      offset: Offset(dx, dy),
      child: SvgPicture.asset(icon,height: iconSize,width: iconSize, colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn,), ),
    );
  }
}
