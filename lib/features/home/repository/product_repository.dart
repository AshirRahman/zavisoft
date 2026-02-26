import 'package:riverpod_app/core/errors/error_handler.dart';
import 'package:riverpod_app/core/network/api_client.dart';
import 'package:riverpod_app/core/network/api_endpoints.dart';
import '../model/product.dart';

class ProductRepository {
  /// Fetches all products from the Fakestore API.
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await ApiClient.get(ApiEndpoints.productsEndpoint);

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Failed to load products. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      final failure = handleError(e);
      throw Exception(failure.message);
    }
  }
}
