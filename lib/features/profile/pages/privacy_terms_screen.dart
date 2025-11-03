import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Terms'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Privacy Policy', style: TextStyles.styleSize20()),
          const Gap(16),
          Text(
            'Last updated: November 3, 2025',
            style: TextStyles.styleSize14(color: AppColors.greyColor),
          ),
          const Gap(24),
          const PolicySection(
            title: '1. Information We Collect',
            content:
                'We collect information that you provide directly to us, including: '
                'name, email address, phone number, and any other information you choose '
                'to provide. We also automatically collect certain information about your '
                'device when you use our services.',
          ),
          const PolicySection(
            title: '2. How We Use Your Information',
            content:
                'We use the information we collect to: '
                '\n• Provide and maintain our services'
                '\n• Process your orders and send you related information'
                '\n• Send you technical notices and support messages'
                '\n• Respond to your comments and questions'
                '\n• Communicate with you about products, services, and events',
          ),
          const PolicySection(
            title: '3. Information Sharing',
            content:
                'We do not sell or rent your personal information to third parties. '
                'We may share your information with third parties only in the ways that '
                'are described in this privacy policy.',
          ),
          const Gap(32),
          Text('Terms of Service', style: TextStyles.styleSize20()),
          const Gap(24),
          const PolicySection(
            title: '1. Account Terms',
            content:
                'You must create an account to use certain features of our service. '
                'You are responsible for maintaining the security of your account and '
                'password. We cannot and will not be liable for any loss or damage from '
                'your failure to maintain the security of your account.',
          ),
          const PolicySection(
            title: '2. Payment Terms',
            content:
                'You agree to pay all charges at the prices then in effect for your '
                'purchases. You must provide current, complete, and accurate billing and '
                'credit card information.',
          ),
          const PolicySection(
            title: '3. Refund Policy',
            content:
                'Items can be returned within 14 days of delivery. The item must be '
                'unused and in the same condition that you received it. The item must be '
                'in the original packaging.',
          ),
        ],
      ),
    );
  }
}

class PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const PolicySection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.styleSize16()),
          const Gap(8),
          Text(
            content,
            style: TextStyles.styleSize14(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
