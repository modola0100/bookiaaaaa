import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shered_preferences.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var user = SheredPreferences.getUserData();
    // TODO: implement initState
    Future.delayed(Duration(seconds: 3), () {
      if (user != null) {
        pushAndRemoveUntil(context, Routes.mainscreen);
      } else {
        pushAndRemoveUntil(context, Routes.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logosvg),
            Text('Order Your Book Now!', style: TextStyles.styleSize18()),
          ],
        ),
      ),
    );
  }
}
