import 'package:bookia/components/buttons/custom_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded) {
      _nameController.text = state.profile.name;
      _phoneController.text = state.profile.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.borderColor,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.greyColor,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.edit,
                        size: 15,
                        color: AppColors.wightColor,
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                ),
                const Gap(16),
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                const Gap(30),
                CustomButton(
                  onPressed: state is ProfileUpdating
                      ? null
                      : () {
                          context.read<ProfileCubit>().updateProfile(
                            name: _nameController.text,
                            phone: _phoneController.text,
                          );
                        },
                  text: state is ProfileUpdating
                      ? 'Updating...'
                      : 'Save Changes',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
