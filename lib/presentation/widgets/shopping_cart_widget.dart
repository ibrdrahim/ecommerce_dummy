import 'package:animations/animations.dart';
import 'package:ecommerce_dummy/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:ecommerce_dummy/presentation/view/product_checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        return OpenContainer<bool>(
            transitionType: ContainerTransitionType.fade,
            openBuilder: (BuildContext _, VoidCallback openContainer) {
              return const ProductCheckoutView();
            },
            // closedShape: const RoundedRectangleBorder(),
            useRootNavigator: true,
            closedElevation: 0.0,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return Stack(
                children: [
                  const IconButton(
                    onPressed: null,
                    disabledColor: Colors.purple,
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 2,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Text(
                          state.totalCartItems > 9
                              ? '9+'
                              : state.totalCartItems.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
