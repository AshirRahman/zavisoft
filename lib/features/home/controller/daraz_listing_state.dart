import '../model/product.dart';

class DarazListingState {
  final bool isLoading;
  final List<Product> products;
  final int selectedTabIndex;
  final String? errorMessage;

  DarazListingState({
    this.isLoading = false,
    this.products = const [],
    this.selectedTabIndex = 0,
    this.errorMessage,
  });

  /// Filtered products based on tab index:
  /// 0 = For You (all products)
  /// 1 = Top Rated (rating >= 4.0)
  /// 2 = Budget (price < 50)
  List<Product> get filteredProducts {
    switch (selectedTabIndex) {
      case 1:
        return products.where((p) => (p.rating ?? 0) >= 4.0).toList();
      case 2:
        return products.where((p) => p.price < 50).toList();
      default:
        return products;
    }
  }

  DarazListingState copyWith({
    bool? isLoading,
    List<Product>? products,
    int? selectedTabIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DarazListingState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
