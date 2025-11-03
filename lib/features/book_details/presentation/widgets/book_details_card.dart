import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/book_details/data/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookDetailsCard extends StatelessWidget {
  const BookDetailsCard({super.key, required this.book});

  final BookProduct book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: book.mapToProduct());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Hero(
                    tag: AppImages.welcomepng,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: book.image ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) =>
                            Image.asset(
                              AppImages.welcomepng,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
              SizedBox(
                height: 45,
                child: Text(
                  book.name ?? '',
                  style: TextStyles.styleSize18(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(23),
              Row(
                children: [
                  Text(
                    '₹${book.priceAfterDiscount}',
                    style: TextStyles.styleSize16(),
                  ),
                  const Spacer(),
                  MainButton(
                    title: 'Buy',
                    onPressed: () {},
                    backgroundColor: AppColors.darkColor,
                    textColor: AppColors.wightColor,
                    width: 79,
                    height: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
