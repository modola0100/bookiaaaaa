import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custome_text_form_field.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
        title: Text('Edit Profile', style: TextStyles.styleSize24()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 54),
                child: Stack(
                  children: [
                    CircleAvatar(radius: 50, backgroundColor: AppColors.borderColor),
                    Positioned(top: 75, right: 5, child: Icon(Icons.camera_alt_outlined, color: AppColors.primaryColor, size: 30)),
                  ],
                ),
              ),
            ),
            Gap(54),
            CustomeTextFormField(title: 'Full Name', controller: TextEditingController()),
            Gap(12),
            CustomeTextFormField(title: 'Phone', controller: TextEditingController()),
            Gap(12),
            CustomeTextFormField(title: 'Address', controller: TextEditingController()),
            Gap(12),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(title: 'Update Profile', onPressed: () {}),
      ),
    );
  }
}
