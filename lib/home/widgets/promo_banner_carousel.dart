import 'dart:async';
import 'package:flutter/material.dart';

class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({
    super.key,
    required this.slides,
    this.height = 168,
    this.autoScrollInterval = const Duration(seconds: 4),
  });

  final List<Widget> slides;
  final double height;
  final Duration autoScrollInterval;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  final PageController _pageController = PageController();
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.slides.length > 1) {
      _autoScrollTimer = Timer.periodic(widget.autoScrollInterval, (_) {
        if (!_pageController.hasClients) return;
        final nextPage = _currentPage + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: widget.slides[index % widget.slides.length],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}