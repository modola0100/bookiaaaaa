import 'package:bookia/components/app_bar/app_bar_widget.dart';
import 'package:bookia/components/inputs/custome_text_form_field.dart';
import 'package:bookia/core/functions/debouncer.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/core/widgets/shimmer_search.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookia/features/book_details/presentation/cubit/book_details_state.dart';
import 'package:bookia/features/book_details/presentation/widgets/book_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BookDetailsCubit>();

    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
          if (state is! BookDetailsISuccessState) {
            return const ProductCardSearchShimmer();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 21, right: 21, top: 26),
            child: Column(
              children: [
                CustomeTextFormField(
                  onChanged: (value) {
                    _debouncer.run(() => cubit.getSearchBook(value));
                  },
                  title: 'Search Store',
                  controller: cubit.searchController,
                  prefix: Icon(
                    Icons.search_rounded,
                    color: AppColors.darkColor,
                    size: 30,
                  ),
                ),
                Gap(24),
                Expanded(
                  child: cubit.searchResault()
                      ? Center(
                          child: Text(
                            'Book Not Found',
                            style: TextStyles.styleSize16(),
                          ),
                        )
                      : BookDetailsWidget(books: cubit.displayProduct()),
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
    context.read<BookDetailsCubit>().searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }
}
