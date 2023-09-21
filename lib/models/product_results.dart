import 'package:ecommerce_dummy/models/product.dart';

class ProductResults {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductResults({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductResults copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      ProductResults(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory ProductResults.fromJson(Map<String, dynamic> json) => ProductResults(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );
}
