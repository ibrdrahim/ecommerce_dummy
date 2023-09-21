part of 'shopping_cart_bloc.dart';

final class ShoppingCartState extends Equatable {
  const ShoppingCartState({
    this.cartItem = const <Map<Product, int>>[],
    this.totalCartItems = 0,
    this.totalCartValue = 0,
    this.totalDiscountValue = 0,
  });

  /// to store the cart item, the product and the quantity.
  final List<Map<Product, int>> cartItem;
  final int totalCartItems;
  final double totalCartValue;
  final double totalDiscountValue;

  ShoppingCartState copyWith({
    List<Map<Product, int>>? cartItem,
    int? totalCartItems,
    double? totalCartValue,
    double? totalDiscountValue,
  }) {
    return ShoppingCartState(
      cartItem: cartItem ?? this.cartItem,
      totalCartItems: totalCartItems ?? this.totalCartItems,
      totalCartValue: totalCartValue ?? this.totalCartValue,
      totalDiscountValue: totalDiscountValue ?? this.totalDiscountValue,
    );
  }

  @override
  List<Object> get props => [
        cartItem,
        totalCartItems,
        totalCartValue,
        totalDiscountValue,
      ];
}
