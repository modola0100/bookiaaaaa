import 'package:bookia/components/app_bar/app_bar_widget.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is HomeSuccessState) {
          pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 500),
              content: Text(
                state.message ?? '',
                style: TextStyles.styleSize16(color: AppColors.wightColor),
              ),
              backgroundColor: AppColors.primaryColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is HomeErrorState) {
          pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Not Added to wishlist',
                style: TextStyles.styleSize16(color: AppColors.wightColor),
              ),
              backgroundColor: AppColors.redColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(
            image: GestureDetector(
              onTap: () {
                cubit.addAndRemoveTowishList(productId: book.id ?? 0);
              },
              child: cubit.cachedIfWishlist(book.id ?? 0)
                  ? SvgPicture.asset(
                      AppImages.bookmarksvg,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : SvgPicture.asset(AppImages.bookmarksvg),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 24, left: 24),
                child: Column(
                  children: [
                    Hero(
                      tag: book.id ?? '',
                      child: CachedNetworkImage(
                        imageUrl: book.image ?? '',
                        height: 200,
                      ),
                    ),
                    const Gap(11),
                    Text(book.name ?? '', style: TextStyles.styleSize30()),
                    Text(
                      book.category ?? '',
                      style: TextStyles.styleSize16(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      book.description ?? '',
                      style: TextStyles.styleSize14(),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: SafeArea(
              child: Row(
                children: [
                  Text(
                    '₹${book.priceAfterDiscount}',
                    style: TextStyles.styleSize24(),
                  ),
                  const Spacer(),
                  MainButton(
                    title: 'Add To Cart',
                    onPressed: () {
                      cubit.addToCart(productId: book.id ?? 0);
                    },
                    backgroundColor: AppColors.darkColor,
                    textColor: AppColors.wightColor,
                    width: 212,
                    height: 56,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
