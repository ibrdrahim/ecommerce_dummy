import 'package:ecommerce_dummy/presentation/widgets/app_bar_widget.dart';
import 'package:ecommerce_dummy/presentation/widgets/product_list_widget.dart';
import 'package:ecommerce_dummy/presentation/widgets/product_search_widget.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: 'Ecommerce Dummy',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductSearchWidget(),
          Expanded(child: ProductListsWidget()),
        ],
      ),
    );
  }
}
