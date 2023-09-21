import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_dummy/models/product.dart';
import 'package:ecommerce_dummy/repositories/product_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

const _limitPerPage = 20;
const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductListBloc extends Bloc<ProductListEvent, ProductListStates> {
  ProductListBloc() : super(const ProductListStates()) {
    /// On FetchProducts event, we will fetch the products.
    /// If the state is initial, we will fetch the first page of products.
    /// If the state is success, we will fetch the next page of products.
    on<FetchProducts>(
      (event, emit) async {
        if (state.hasReachedMax) return;
        try {
          if (state.status == ProductListStatus.initial) {
            final productResults = await ProductRepositories().getProducts(
              search: state.search ?? '',
            );
            final products = productResults.products ?? [];
            return emit(state.copyWith(
              status: ProductListStatus.success,
              products: products,
              hasReachedMax: products.length < _limitPerPage,
            ));
          }

          final productResults = await ProductRepositories().getProducts(
            skip: state.products.length,
            search: state.search ?? '',
          );
          final products = productResults.products ?? [];
          return emit(state.copyWith(
            status: ProductListStatus.success,
            products: List.of(state.products)..addAll(products),
            hasReachedMax: products.length < _limitPerPage,
          ));
        } catch (_) {
          return emit(state.copyWith(status: ProductListStatus.failure));
        }
      },
      transformer: throttleDroppable(throttleDuration),
    );

    /// On SearchProducts event, we will reset the state and fetch the products.
    on<SearchProducts>(
      (event, emit) async {
        if (event.search.length < 3) return;

        final productResults = await ProductRepositories().getProducts(
          search: event.search,
        );
        final products = productResults.products ?? [];
        return emit(state.copyWith(
          search: event.search,
          status: ProductListStatus.success,
          products: products,
          hasReachedMax: products.length < _limitPerPage,
        ));
      },
      transformer: throttleDroppable(throttleDuration),
    );

    /// On ClearSearchProducts event, we will reset the state and fetch the products.
    on<ClearSearchProducts>(
      (event, emit) async {
        final productResults = await ProductRepositories().getProducts();
        final products = productResults.products ?? [];

        return emit(state.copyWith(
          search: '',
          status: ProductListStatus.success,
          products: products,
          hasReachedMax: products.length < _limitPerPage,
        ));
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }
}
