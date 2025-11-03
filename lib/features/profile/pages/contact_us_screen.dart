import 'package:bookia/components/buttons/custom_button.dart';
import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get in touch with us', style: TextStyles.styleSize20()),
              const Gap(8),
              Text(
                'We\'d love to hear from you. Please fill out this form or send us an email.',
                style: TextStyles.styleSize14(color: AppColors.greyColor),
              ),
              const Gap(24),
              CustomTextField(
                controller: _nameController,
                hintText: 'Your Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const Gap(16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Your Message',
                    hintStyle: TextStyles.styleSize14(
                      color: AppColors.greyColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const Gap(24),
              CustomButton(
                text: 'Send Message',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement send message functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Message sent successfully'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
              const Gap(32),
              const ContactInfoItem(
                icon: Icons.phone,
                title: 'Phone',
                content: '+1 (123) 456-7890',
              ),
              const Gap(16),
              const ContactInfoItem(
                icon: Icons.email,
                title: 'Email',
                content: 'support@bookia.com',
              ),
              const Gap(16),
              const ContactInfoItem(
                icon: Icons.location_on,
                title: 'Address',
                content: '123 Book Street, Reading City, 12345',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryColor),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.styleSize16()),
            Text(
              content,
              style: TextStyles.styleSize14(color: AppColors.greyColor),
            ),
          ],
        ),
      ],
    );
  }
}
