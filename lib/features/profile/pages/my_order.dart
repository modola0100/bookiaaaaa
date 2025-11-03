import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () {
              pop(context);
            },
            child: SvgPicture.asset(AppImages.backsvg, width: 30, height: 30),
          ),
        ),
        title: Text('My Orders', style: TextStyles.styleSize20()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text('Order No238562312', style: TextStyles.styleSize14()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: Text('20/03/2020', style: TextStyles.styleSize14(color: AppColors.greyColor)),
                ),
              ],
            ),
            Divider(),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text('Total Amount: \$150', style: TextStyles.styleSize16()),
            ),
          ],
        ),
      ),
    );
  }
}
