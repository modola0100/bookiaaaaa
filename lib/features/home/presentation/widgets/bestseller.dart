import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/widgets/product_best_card.dart';
import 'package:flutter/material.dart';

class Bestseller extends StatelessWidget {
  const Bestseller({super.key, required this.books});

  final List<Product> books;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 11,
        crossAxisSpacing: 11,
        mainAxisExtent: 281,
      ),
      itemBuilder: (context, index) => ProductBestCard(book: books[index]),
      itemCount: books.length,
    );
  }
}
