import 'package:animations/animations.dart';
import 'package:ecommerce_dummy/models/product.dart';
import 'package:ecommerce_dummy/presentation/view/empty_view.dart';
import 'package:ecommerce_dummy/presentation/view/product_detail_view.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        var width = MediaQuery.of(context).size.width *
            (orientation == Orientation.portrait ? 0.5 : 0.3);

        return OpenContainer<bool>(
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext _, VoidCallback openContainer) {
            if (product.id == null) return const EmptyView();

            return ProductDetailView(product: product);
          },
          // closedShape: const RoundedRectangleBorder(),
          useRootNavigator: true,
          closedElevation: 0.0,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return Container(
              width: width,
              decoration: BoxDecoration(
                // color: Colors.purple.withAlpha(20),
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x3600000F),
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: product.thumbnail != null
                            ? Image.network(
                                product.thumbnail!,
                                width: width,
                                // height: 100,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: width,
                                color: Colors.grey[200],
                              )),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          Text(
                            product.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            // style: AppTheme.of(context).bodyText1,
                          ),
                          const SizedBox(height: 4),
                          if (product.discountPercentage != null) ...[
                            Text(
                              '\$${product.discountPriceString}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
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
                              ],
                            ),
                          ] else
                            Text(
                              '\$${product.price}',
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
