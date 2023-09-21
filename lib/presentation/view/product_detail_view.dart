import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';
import 'package:ecommerce_dummy/models/product.dart';
import 'package:ecommerce_dummy/presentation/view/empty_view.dart';
import 'package:ecommerce_dummy/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_dummy/presentation/widgets/product_detail_widget.dart';
import 'package:ecommerce_dummy/repositories/product_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({required this.product, Key? key}) : super(key: key);

  final Product product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  Product? product;

  @override
  void initState() {
    // Set product from widget as default.
    product = widget.product;
    // make sure network is available before fetching.
    // fetch product detail from API to get the latest data.
    if (context.read<NetworkBloc>().state is NetworkSuccess) {
      ProductRepositories().getProduct(widget.product.id!).then((value) {
        setState(() {
          product = value;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const EmptyView();
    }

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Product Detail',
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: PageView.builder(
                      itemCount: product!.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Image.network(
                          product!.images![index],
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitHeight,
                        );
                      }),
                ),
                Flexible(
                  child: ProductDetailWidget(product: product!),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView.builder(
                    itemCount: product!.images?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Image.network(
                        product!.images![index],
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitHeight,
                      );
                    }),
              ),
              Flexible(
                child: ProductDetailWidget(product: product!),
              ),
            ],
          );
        },
      ),
    );
  }
}
