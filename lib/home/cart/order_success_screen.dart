import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/core/theme/app_colors.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    final random = math.Random();
    _particles = List.generate(28, (index) {
      final angle = random.nextDouble() * 2 * math.pi;
      final speed = 120 + random.nextDouble() * 160;
      return _ConfettiParticle(
        angle: angle,
        speed: speed,
        color: _confettiColors[random.nextInt(_confettiColors.length)],
        size: 6 + random.nextDouble() * 6,
        spin: (random.nextDouble() - 0.5) * 10,
        delay: random.nextDouble() * 0.15,
      );
    });
  }

  static const _confettiColors = [
    AppColors.primary,
    Color(0xFFFFC145),
    Color(0xFF4BB543),
    Color(0xFF3D9BE9),
    Color(0xFFE85A2A),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Confetti burst, centered behind the checkmark
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: _ConfettiPainter(
                    progress: _controller.value,
                    particles: _particles,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCheckmark(),
                  const SizedBox(height: 32),
                  _buildFadeSlide(
                    interval: const Interval(0.5, 0.8, curve: Curves.easeOut),
                    child: Text(
                      'Congratulations!',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildFadeSlide(
                    interval: const Interval(0.6, 0.9, curve: Curves.easeOut),
                    child: Text(
                      'Your order has been placed successfully',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildFadeSlide(
                    interval: const Interval(0.75, 1.0, curve: Curves.easeOut),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Back to Home',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFadeSlide({required Interval interval, required Widget child}) {
    final animation = CurvedAnimation(parent: _controller, curve: interval);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value.clamp(0.0, 1.0)) * 16),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildCheckmark() {
    final circleAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
    );
    final checkAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.scale(
          scale: circleAnim.value.clamp(0.0, 1.2),
          child: SizedBox(
            width: 120,
            height: 120,
            child: CustomPaint(
              painter: _CheckmarkPainter(
                circleProgress: circleAnim.value.clamp(0.0, 1.0),
                checkProgress: checkAnim.value.clamp(0.0, 1.0),
                color: const Color(0xFF267E3E),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  _CheckmarkPainter({
    required this.circleProgress,
    required this.checkProgress,
    required this.color,
  });

  final double circleProgress;
  final double checkProgress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * circleProgress.clamp(0.0, 1.0), circlePaint);

    if (checkProgress <= 0) return;

    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Checkmark points, relative to the box.
    final p1 = Offset(size.width * 0.28, size.height * 0.53);
    final p2 = Offset(size.width * 0.44, size.height * 0.68);
    final p3 = Offset(size.width * 0.75, size.height * 0.34);

    final path = Path();
    final firstLegLength = (p2 - p1).distance;
    final secondLegLength = (p3 - p2).distance;
    final totalLength = firstLegLength + secondLegLength;
    final drawLength = totalLength * checkProgress.clamp(0.0, 1.0);

    path.moveTo(p1.dx, p1.dy);
    if (drawLength <= firstLegLength) {
      final t = firstLegLength == 0 ? 0 : drawLength / firstLegLength;
      final point = Offset.lerp(p1, p2, t.toDouble())!;
      path.lineTo(point.dx, point.dy);
    } else {
      path.lineTo(p2.dx, p2.dy);
      final remaining = drawLength - firstLegLength;
      final t = secondLegLength == 0 ? 0 : remaining / secondLegLength;
      final point = Offset.lerp(p2, p3, t.toDouble())!;
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _CheckmarkPainter oldDelegate) {
    return oldDelegate.circleProgress != circleProgress || oldDelegate.checkProgress != checkProgress;
  }
}

class _ConfettiParticle {
  _ConfettiParticle({
    required this.angle,
    required this.speed,
    required this.color,
    required this.size,
    required this.spin,
    required this.delay,
  });

  final double angle;
  final double speed;
  final Color color;
  final double size;
  final double spin;
  final double delay;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress, required this.particles});

  final double progress;
  final List<_ConfettiParticle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.36);
    const gravity = 260.0;

    for (final particle in particles) {
      final localT = ((progress - particle.delay) / (1 - particle.delay)).clamp(0.0, 1.0);
      if (localT <= 0) continue;

      final opacity = localT > 0.7 ? (1 - (localT - 0.7) / 0.3).clamp(0.0, 1.0) : 1.0;
      if (opacity <= 0) continue;

      final dx = math.cos(particle.angle) * particle.speed * localT;
      final dy = math.sin(particle.angle) * particle.speed * localT +
          0.5 * gravity * localT * localT;

      final paint = Paint()
        ..color = particle.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      final pos = center + Offset(dx, dy);
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(particle.spin * localT);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: particle.size, height: particle.size * 0.6),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}