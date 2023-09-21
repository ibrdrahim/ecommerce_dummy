part of 'shopping_cart_bloc.dart';

sealed class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends ShoppingCartEvent {
  final Product product;
  final int quantity;

  const AddToCart(this.product, this.quantity);

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends ShoppingCartEvent {
  final Product product;

  const RemoveFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateCartItem extends ShoppingCartEvent {
  final Product product;
  final int quantity;

  const UpdateCartItem(this.product, this.quantity);

  @override
  List<Object> get props => [product];
}

class ClearCartItem extends ShoppingCartEvent {}
