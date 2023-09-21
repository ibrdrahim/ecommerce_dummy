part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Product> get props => [];
}

class FetchProducts extends ProductListEvent {}

class SearchProducts extends ProductListEvent {
  final String search;

  const SearchProducts(this.search);
}

class ClearSearchProducts extends ProductListEvent {}
