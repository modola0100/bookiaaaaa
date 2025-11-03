import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          FAQItem(
            question: 'How do I place an order?',
            answer:
                'You can place an order by selecting the books you want to purchase, '
                'adding them to your cart, and proceeding to checkout. Make sure you\'re '
                'logged in to your account before placing an order.',
          ),
          SizedBox(height: 16),
          FAQItem(
            question: 'What payment methods do you accept?',
            answer:
                'We accept various payment methods including credit/debit cards, '
                'PayPal, and other local payment options. You can view all available '
                'payment methods during checkout.',
          ),
          SizedBox(height: 16),
          FAQItem(
            question: 'How long does delivery take?',
            answer:
                'Delivery times vary depending on your location and the shipping '
                'method chosen. Typically, orders are delivered within 3-7 business days '
                'for domestic shipping.',
          ),
          SizedBox(height: 16),
          FAQItem(
            question: 'Can I return a book?',
            answer:
                'Yes, you can return a book within 14 days of delivery if it\'s in '
                'its original condition. Please check our returns policy for more details.',
          ),
          SizedBox(height: 16),
          FAQItem(
            question: 'How can I track my order?',
            answer:
                'Once your order is shipped, you\'ll receive a tracking number via '
                'email. You can also track your order from the "My Orders" section in '
                'your profile.',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.wightColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: const Color(0x338A959E),
            offset: const Offset(0, 7),
            blurRadius: 40,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(widget.question, style: TextStyles.styleSize16()),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        trailing: Icon(
          _isExpanded ? Icons.remove : Icons.add,
          color: AppColors.primaryColor,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              widget.answer,
              style: TextStyles.styleSize14(color: AppColors.greyColor),
            ),
          ),
        ],
      ),
    );
  }
}
