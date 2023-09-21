import 'package:bloc/bloc.dart';
import 'package:ecommerce_dummy/models/product.dart';
import 'package:equatable/equatable.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(const ShoppingCartState()) {
    /// Add products to cart, used when user clicks on add to cart button.
    on<AddToCart>((event, emit) {
      final cartItem = List<Map<Product, int>>.from(state.cartItem);
      final index = cartItem
          .indexWhere((element) => element.keys.first.id == event.product.id);
      if (index >= 0) {
        cartItem[index]
            .update(event.product, (value) => value + event.quantity);
      } else {
        cartItem.add({event.product: event.quantity});
      }

      emit(state.copyWith(
        cartItem: cartItem,
        totalCartItems: getTotalCartItems(cartItem),
        totalCartValue: getTotalCartValue(cartItem),
        totalDiscountValue: getTotalCartDiscountValue(cartItem),
      ));
    });

    /// Remove products from cart, used when user clicks on remove from cart button.
    on<RemoveFromCart>((event, emit) {
      final cartItem = List<Map<Product, int>>.from(state.cartItem);
      final index = cartItem
          .indexWhere((element) => element.keys.first.id == event.product.id);
      if (index >= 0) {
        cartItem.removeAt(index);
      }
      emit(state.copyWith(
        cartItem: cartItem,
        totalCartItems: getTotalCartItems(cartItem),
        totalCartValue: getTotalCartValue(cartItem),
        totalDiscountValue: getTotalCartDiscountValue(cartItem),
      ));
    });

    /// Update products in cart, used when user changes the quantity of the product.
    on<UpdateCartItem>((event, emit) {
      final cartItem = List<Map<Product, int>>.from(state.cartItem);
      final index = cartItem
          .indexWhere((element) => element.keys.first.id == event.product.id);
      if (index >= 0) {
        cartItem[index].update(event.product, (value) => event.quantity);
      }
      emit(state.copyWith(
        cartItem: cartItem,
        totalCartItems: getTotalCartItems(cartItem),
        totalCartValue: getTotalCartValue(cartItem),
        totalDiscountValue: getTotalCartDiscountValue(cartItem),
      ));
    });

    /// Clear the cart.
    on<ClearCartItem>((event, emit) {
      emit(state.copyWith(
        cartItem: [],
        totalCartItems: 0,
        totalCartValue: 0,
        totalDiscountValue: 0,
      ));
    });
  }

  int getTotalCartItems(List<Map<Product, int>> cartItem) => cartItem.fold(
        0,
        (previousValue, element) => previousValue + element.values.first,
      );

  double getTotalCartDiscountValue(List<Map<Product, int>> cartItem) =>
      cartItem.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.keys.first.price! - element.keys.first.discountPrice) *
                element.values.first,
      );

  double getTotalCartValue(List<Map<Product, int>> cartItem) => cartItem.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.keys.first.discountPrice * element.values.first,
      );
}
