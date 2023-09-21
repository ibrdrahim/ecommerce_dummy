import 'package:ecommerce_dummy/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:ecommerce_dummy/models/product.dart';
import 'package:ecommerce_dummy/repositories/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({required this.product, Key? key})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    product.rating != null
                        ? Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                                size: 16,
                              ),
                              Text(
                                '${product.rating}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(height: 4),
                    if (product.discountPercentage != null) ...[
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(50),
                              borderRadius: BorderRadius.circular(2),
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
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${product.discountPriceString}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ] else
                      Text(
                        '\$${product.price}',
                      ),
                  ],
                ),
              ),

              /// Add to cart button.
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        LocalNotificationService().showLocalNotification(
                            'Product added to cart!',
                            '${product.title} has been added to cart.');
                        context
                            .read<ShoppingCartBloc>()
                            .add(AddToCart(product, 1));
                      },
                      child: const Text('Add to cart'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            product.title ?? '',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          Text(
            'Details',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Brand',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                product.brand ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Stock',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                product.stock.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Category',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                product.category ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            product.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
