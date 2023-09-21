import 'dart:convert';

import 'package:ecommerce_dummy/models/product.dart';
import 'package:ecommerce_dummy/models/product_results.dart';
import 'package:http/http.dart' as http;

class ProductRepositories {
  /// root url for the api.
  String root = 'https://dummyjson.com/products';

  /// Get a list of products.
  /// if [search] is not empty, it will search for products with the given query.
  Future<ProductResults> getProducts({
    int skip = 0,
    String search = '',
  }) async {
    try {
      String urlString = search.isNotEmpty
          ? '$root/search?q=$search&skip=$skip'
          : '$root?skip=$skip';
      Uri url = Uri.parse(urlString);
      http.Response response = await http.get(url);
      ProductResults results =
          ProductResults.fromJson(json.decode(response.body));
      return results;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single product.
  Future<Product> getProduct(int id) async {
    try {
      Uri url = Uri.parse('$root/$id');
      http.Response response = await http.get(url);
      Product results = Product.fromJson(json.decode(response.body));
      return results;
    } catch (e) {
      rethrow;
    }
  }
}
