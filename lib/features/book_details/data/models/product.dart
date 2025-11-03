import 'package:bookia/features/home/data/models/best_seller_response/product.dart';

class BookProduct {
  int? id;
  String? name;
  String? description;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  int? stock;
  int? bestSeller;
  String? image;
  String? category;

  BookProduct({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.stock,
    this.bestSeller,
    this.image,
    this.category,
  });

  factory BookProduct.fromJson(Map<String, dynamic> json) => BookProduct(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: json['price'] as String?,
    discount: json['discount'] as int?,
    priceAfterDiscount: (json['price_after_discount'] as num?)?.toDouble(),
    stock: json['stock'] as int?,
    bestSeller: json['best_seller'] as int?,
    image: json['image'] as String?,
    category: json['category'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'discount': discount,
    'price_after_discount': priceAfterDiscount,
    'stock': stock,
    'best_seller': bestSeller,
    'image': image,
    'category': category,
  };

  Product mapToProduct() {
    return Product(
      id: id,
      name: name,
      price: price,
      category: category,
      image: image,
      discount: discount,
      stock: stock,
      description: description,
      bestSeller: bestSeller,
      priceAfterDiscount: double.tryParse(price ?? '0'),
    );
  }
}
