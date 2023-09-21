part of 'product_list_bloc.dart';

enum ProductListStatus { initial, success, failure }

final class ProductListStates extends Equatable {
  final ProductListStatus status;
  final List<Product> products;
  final String? search;
  final bool hasReachedMax;

  const ProductListStates({
    this.status = ProductListStatus.initial,
    this.products = const <Product>[],
    this.search = '',
    this.hasReachedMax = false,
  });

  ProductListStates copyWith({
    ProductListStatus? status,
    List<Product>? products,
    String? search,
    bool? hasReachedMax,
  }) {
    return ProductListStates(
      status: status ?? this.status,
      products: products ?? this.products,
      search: search ?? this.search,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
