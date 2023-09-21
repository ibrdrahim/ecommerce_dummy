import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';
import 'package:ecommerce_dummy/bloc/product_list/product_list_bloc.dart';
import 'package:ecommerce_dummy/presentation/widgets/shopping_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widget for search bar.
/// This widget will call [SearchProducts] from [ProductListBloc].
class ProductSearchWidget extends StatefulWidget {
  const ProductSearchWidget({Key? key}) : super(key: key);

  @override
  State<ProductSearchWidget> createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ProductSearchWidget> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: SearchBar(
              controller: searchController,
              hintText: 'Search Products',
              onChanged: (value) {
                /// Only search when network is available.
                if (context.read<NetworkBloc>().state is NetworkSuccess) {
                  return context
                      .read<ProductListBloc>()
                      .add(SearchProducts(value));
                }
              },
              leading: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.search),
              ),
              trailing: <Widget>[
                Tooltip(
                  message: 'Clear Search',
                  child: IconButton(
                    onPressed: () {
                      if (searchController.text == '') return;

                      searchController.text = '';
                      context
                          .read<ProductListBloc>()
                          .add(ClearSearchProducts());
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ],
            ),
          ),
          const ShoppingCartWidget(),
        ],
      ),
    );
  }
}
