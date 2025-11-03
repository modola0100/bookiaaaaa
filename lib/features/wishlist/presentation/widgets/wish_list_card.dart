import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response/datum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onRefresh,
    required this.onPressed,
  });

  final WishListProduct book;
  final Function() onDelete;
  final Function() onRefresh;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          pushTo(context, Routes.details, extra: book.mapToProduct()).then((
            value,
          ) {
            onRefresh();
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: book.image ?? '',
                  fit: BoxFit.contain,
                  height: 130,
                  width: 100,
                ),
                Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              book.name ?? '',
                              style: TextStyles.styleSize18(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onDelete,
                            child: SvgPicture.asset(AppImages.shape),
                          ),
                        ],
                      ),
                      Gap(10),
                      Text('₹${book.price}', style: TextStyles.styleSize16()),
                      Gap(25),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MainButton(
                          title: 'Add To Cart',
                          onPressed: onPressed,
                          width: 181.78,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
