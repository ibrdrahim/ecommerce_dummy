import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';
import 'package:ecommerce_dummy/bloc/product_list/product_list_bloc.dart';
import 'package:ecommerce_dummy/presentation/widgets/product_loader_widget.dart';
import 'package:ecommerce_dummy/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListsWidget extends StatefulWidget {
  const ProductListsWidget({super.key});

  @override
  State<ProductListsWidget> createState() => _ProductListsWidgetState();
}

class _ProductListsWidgetState extends State<ProductListsWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListStates>(
      builder: (context, state) {
        switch (state.status) {
          case ProductListStatus.failure:
            return BlocBuilder<NetworkBloc, NetworkState>(
              builder: (context, networkState) {
                if (networkState is NetworkSuccess) {
                  context.read<ProductListBloc>().add(FetchProducts());
                }

                return const Center(child: Text('You are offline'));
              },
            );
          case ProductListStatus.success:
            if (state.products.isEmpty) {
              return const Center(child: Text('No products'));
            }

            return OrientationBuilder(
              builder: (context, orientation) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: GridView.count(
                    controller: _scrollController,
                    // Create a grid with 2 columns in portrait mode,
                    // or 3 columns in landscape mode.
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,

                    children: List.generate(
                        state.hasReachedMax
                            ? state.products.length
                            : state.products.length + 1, (index) {
                      return index >= state.products.length
                          ? const ProductLoaderWidget()
                          : ProductItemWidget(product: state.products[index]);
                    }),
                  ),
                );
              },
            );

          case ProductListStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    bool isNetworkAvailable =
        context.read<NetworkBloc>().state is NetworkSuccess;

    if (_isBottom && isNetworkAvailable) {
      context.read<ProductListBloc>().add(FetchProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
