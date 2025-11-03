import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.cartItem, required this.onDelete, required this.onUpdate});

  final CartItem cartItem;
  final Function() onDelete;
  final Function(int) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: cartItem.itemProductImage ?? '',
                fit: BoxFit.contain,
                height: 118,
                width: 100,
                errorWidget: (context, error, stackTrace) => Image.asset(AppImages.welcomepng, fit: BoxFit.cover, width: double.infinity),
              ),
              Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(cartItem.itemProductName ?? '', style: TextStyles.styleSize18(color: AppColors.greyColor)),
                        ),
                        GestureDetector(
                          onTap: () {
                            onDelete();
                          },
                          child: SvgPicture.asset(AppImages.shape),
                        ),
                      ],
                    ),
                    Gap(10),
                    Text('₹${cartItem.itemProductPrice}', style: TextStyles.styleSize16()),
                    Gap(25),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((cartItem.itemQuantity ?? 1) < (cartItem.itemProductStock ?? 1)) {
                              int newQuantity = (cartItem.itemQuantity ?? 1) + 1;
                              onUpdate(newQuantity);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  margin: EdgeInsets.only(bottom: 200, right: 20, left: 20),
                                  content: Text('Out of Stock', style: TextStyles.styleSize16(color: AppColors.wightColor)),
                                  backgroundColor: AppColors.primaryColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                                ),
                              );
                            }
                          },
                          child: SvgPicture.asset(AppImages.add),
                        ),
                        Gap(15),
                        Text((cartItem.itemQuantity ?? 1) < 10 ? '0${cartItem.itemQuantity}' : cartItem.itemQuantity.toString(), style: TextStyles.styleSize18()),
                        Gap(15),
                        GestureDetector(
                          onTap: () {
                            if ((cartItem.itemQuantity ?? 1) > 1) {
                              int newQuantity = (cartItem.itemQuantity ?? 1) - 1;
                              onUpdate(newQuantity);
                            }
                          },
                          child: SvgPicture.asset(AppImages.remove),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
