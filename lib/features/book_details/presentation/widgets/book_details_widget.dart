import 'package:bookia/features/book_details/data/models/product.dart';
import 'package:bookia/features/book_details/presentation/widgets/book_details_card.dart';
import 'package:flutter/material.dart';

class BookDetailsWidget extends StatelessWidget {
  const BookDetailsWidget({super.key, required this.books});

  final List<BookProduct> books;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ClampingScrollPhysics(),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 281,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
      ),
      itemBuilder: (context, index) {
        return BookDetailsCard(book: books[index]);
      },
      itemCount: books.length,
    );
  }
}
