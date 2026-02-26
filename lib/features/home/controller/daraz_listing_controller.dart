import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/core/network/api_client.dart';
import 'package:riverpod_app/core/network/api_endpoints.dart';
import '../model/product.dart';
import 'daraz_listing_state.dart';

final darazListingProvider =
    StateNotifierProvider<DarazListingController, DarazListingState>(
  (ref) => DarazListingController(),
);

class DarazListingController extends StateNotifier<DarazListingState> {
  DarazListingController() : super(DarazListingState()) {
    loadProducts();
  }

  /// Fetches all products from the Fakestore API.
  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await ApiClient.get(ApiEndpoints.productsEndpoint);
      final products = (response.data as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

      state = state.copyWith(
        products: products,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Changes the active tab index. The view re-filters via [DarazListingState.filteredProducts].
  void changeTab(int index) {
    if (index == state.selectedTabIndex) return;
    state = state.copyWith(selectedTabIndex: index);
  }
}
