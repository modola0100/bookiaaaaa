import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/features/cart/presentation/pages/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/pages/profile_screen.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index});

  final int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screen = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? currentIndex;
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    currentIndex = widget.index ?? currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.wightColor,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          _buildNavigationBarItem(iconPath: AppImages.homesvg, label: 'Home'),
          _buildNavigationBarItem(
            iconPath: AppImages.bookmarksvg,
            label: 'Wishlist',
          ),
          _buildNavigationBarItem(iconPath: AppImages.cartsvg, label: 'Cart'),
          _buildNavigationBarItem(
            iconPath: AppImages.profile,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem({
    required String iconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(iconPath),
      label: label,
    );
  }
}
