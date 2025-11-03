import 'package:bookia/components/app_bar/app_bar_widget.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custome_text_form_field.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('New Password', style: TextStyles.styleSize30())),
            Gap(73),
            CustomeTextFormField(title: 'Current Password', controller: TextEditingController()),
            Gap(26),
            CustomeTextFormField(title: 'New Password', controller: TextEditingController()),
            Gap(26),
            CustomeTextFormField(title: 'Confirm password', controller: TextEditingController()),
            Gap(26),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MainButton(title: 'Update Password', onPressed: () {}),
      ),
    );
  }
}
