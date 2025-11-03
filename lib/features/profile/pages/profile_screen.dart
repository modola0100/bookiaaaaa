import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/profile/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () {
                  // TODO: Implement logout
                },
                child: SvgPicture.asset(
                  AppImages.logoutsvg,
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(padding: const EdgeInsets.only(right: 19)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.borderColor,
                      backgroundImage:
                          state is ProfileLoaded && state.profile.avatar != null
                          ? NetworkImage(state.profile.avatar!)
                          : null,
                      child:
                          state is ProfileLoaded && state.profile.avatar == null
                          ? Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.greyColor,
                            )
                          : null,
                    ),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state is ProfileLoaded
                              ? state.profile.name
                              : 'Loading...',
                          style: TextStyles.styleSize20(),
                        ),
                        Text(
                          state is ProfileLoaded
                              ? state.profile.email
                              : 'Loading...',
                          style: TextStyles.styleSize14(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(35),
                ProfileCard(
                  title: 'My Orders',
                  onTap: () {
                    pushTo(context, Routes.myOrder);
                  },
                ),
                Gap(10),
                ProfileCard(
                  title: 'Edit Profile',
                  onTap: () {
                    pushTo(context, Routes.editProfile);
                  },
                ),
                Gap(10),
                ProfileCard(
                  title: 'Reset Password',
                  onTap: () {
                    pushTo(context, Routes.resetPassword);
                  },
                ),
                Gap(10),
                ProfileCard(
                  title: 'FAQ',
                  onTap: () {
                    pushTo(context, Routes.faq);
                  },
                ),
                Gap(10),
                ProfileCard(
                  title: 'Contact Us',
                  onTap: () {
                    pushTo(context, Routes.contactUs);
                  },
                ),
                Gap(10),
                ProfileCard(
                  title: 'Privacy & Terms',
                  onTap: () {
                    pushTo(context, Routes.privacyTerms);
                  },
                ),
                Gap(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
