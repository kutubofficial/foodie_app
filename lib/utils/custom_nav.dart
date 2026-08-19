import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItem> _items = [
    _NavItem(
      icon: 'assets/icons/home.svg',
      activeIcon: 'assets/icons/home.svg',
    ),
    _NavItem(
      icon: 'assets/icons/search.svg',
      activeIcon: 'assets/icons/search.svg',
    ),
    _NavItem(
      icon: 'assets/icons/wishlist.svg',
      activeIcon: 'assets/icons/wishlist.svg',
    ),
    _NavItem(
      icon: 'assets/icons/cart.svg',
      activeIcon: 'assets/icons/cart.svg',
    ),
    _NavItem(
      icon: 'assets/icons/profile.svg',
      activeIcon: 'assets/icons/profile.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 74,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black,width: 1,),),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _items.length,
            (index) => _buildItem(_items[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(_NavItem item, int index) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isSelected ? 24 : 20,
              height: isSelected ? 24 : 20,
              child: SvgPicture.asset(
                isSelected ? item.activeIcon : item.icon,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  isSelected? AppColors.primary: const Color.fromRGBO(0, 0, 0, 0.7),
                  BlendMode.srcIn,
                ),
              ),
            ),

            const SizedBox(height: 10),

            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isSelected ? 28 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String activeIcon;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
  });
}