import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigator.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/core/widgets/shimmer.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/bestseller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AppImages.logosvg, width: 99, height: 30),
              IconButton(
                onPressed: () {
                  pushTo(context, Routes.bookdetails);
                },
                icon: Icon(Icons.search_rounded, size: 35),
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            if (state is! HomeSuccessState) {
              return const ProductCardShimmer();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: cubit.sliders?.length ?? 3,
                      itemBuilder: (context, index, realindex) {
                        return ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: cubit.sliders?[index].image ?? '',
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        viewportFraction: 0.95,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(cubit.sliders?.length ?? 3, (
                        index,
                      ) {
                        bool isActive = index == activeIndex;
                        return AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 30 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primaryColor
                                : AppColors.greyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    ),
                    Gap(31),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Best Seller', style: TextStyles.styleSize24()),
                          const Gap(15),
                          Bestseller(books: cubit.products),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
