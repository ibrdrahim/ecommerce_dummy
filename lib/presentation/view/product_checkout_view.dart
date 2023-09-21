import 'package:ecommerce_dummy/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:ecommerce_dummy/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCheckoutView extends StatelessWidget {
  const ProductCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Scaffold(
              appBar: AppBarWidget(
                title: 'Checkout (${state.totalCartItems})',
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: state.cartItem.length,
                        itemBuilder: (context, index) {
                          final product = state.cartItem[index].keys.first;

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x3600000F),
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.thumbnail!,
                                    height:
                                        MediaQuery.of(context).size.width * 0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      if (product.discountPercentage !=
                                          null) ...[
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red.withAlpha(50),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Text(
                                                ' ${product.discountPercentage}% ',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '\$${product.price}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '\$${product.discountPriceString}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ] else
                                        Text(
                                          '\$${product.price}',
                                        ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (state.cartItem[index]
                                                      [product]! <
                                                  2) {
                                                context
                                                    .read<ShoppingCartBloc>()
                                                    .add(RemoveFromCart(
                                                        product));
                                              }

                                              context
                                                  .read<ShoppingCartBloc>()
                                                  .add(UpdateCartItem(
                                                      product,
                                                      state.cartItem[index]
                                                              [product]! -
                                                          1));
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${state.cartItem[index][product]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ShoppingCartBloc>()
                                                  .add(AddToCart(product, 1));
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<ShoppingCartBloc>()
                                        .add(RemoveFromCart(product));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x3600000F),
                          offset: Offset(0, -2),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Total Price',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Text(
                              '\$${state.totalCartValue.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        if (state.totalDiscountValue > 0) ...[
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'You Save',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                '\$${state.totalDiscountValue.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: state.totalCartItems < 1
                              ? null
                              : () {
                                  context
                                      .read<ShoppingCartBloc>()
                                      .add(ClearCartItem());
                                  Navigator.pop(context);
                                },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
