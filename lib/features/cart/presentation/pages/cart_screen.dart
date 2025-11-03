import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('My Cart', style: TextStyles.styleSize24()),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            var books = cubit.cartResponse?.data?.cartItems ?? [];
            if (state is! CartSuccessState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (books.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.cartsvg,
                      height: 100,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gap(10),
                    Text('Add Books to Cart', style: TextStyles.styleSize16()),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return CartCard(
                        cartItem: books[index],
                        onDelete: () {
                          cubit.removeCart(
                            cartItemId: books[index].itemId ?? 0,
                          );
                        },
                        onUpdate: (q) {
                          cubit.updateCart(
                            cartItemId: books[index].itemId ?? 0,
                            quantity: q,
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemCount: books.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total:',
                            style: TextStyles.styleSize20(
                              color: AppColors.greyColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹${cubit.cartResponse?.data?.total ?? 0}',
                            style: TextStyles.styleSize20(),
                          ),
                        ],
                      ),
                      Gap(13),
                      MainButton(
                        title: 'Checkout',
                        onPressed: () {
                          pushTo(
                            context,
                            Routes.placeOrder,
                            extra:
                                cubit.cartResponse?.data?.total.toString() ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
