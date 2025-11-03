import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/services/api_service.dart';
import 'package:bookia/features/cart/presentation/pages/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/pages/profile_screen.dart';
import 'package:bookia/features/profile/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/data/repositories/profile_repository.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index});

  final int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget>? _screens;
  int currentIndex = 0;

  Future<void> _initializeScreens() async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio()..options.baseUrl = 'https://codingarabic.online/api';

    setState(() {
      _screens = [
        HomeScreen(),
        WishlistScreen(),
        CartScreen(),
        BlocProvider(
          create: (context) =>
              ProfileCubit(ProfileRepository(ApiService(dio, prefs))),
          child: ProfileScreen(),
        ),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index ?? currentIndex;
    _initializeScreens();
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    currentIndex = widget.index ?? currentIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_screens == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: _screens![currentIndex],
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
