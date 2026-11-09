import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class FavoritesNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() => [];

  void toggleFavorite(Product product) {
    final isFavorite = state.any(
      (item) => item.id == product.id,
    );

    if (isFavorite) {
      state = state
          .where((item) => item.id != product.id)
          .toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(int productId) {
    return state.any((item) => item.id == productId);
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, List<Product>>(
  FavoritesNotifier.new,
);