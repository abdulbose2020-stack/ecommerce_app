
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addItem(Product product) {
    final exists = state.any(
      (item) => item.product.id == product.id,
    );

    if (exists) {
      increaseQuantity(product.id);
    } else {
      state = [
        ...state,
        CartItem(product: product),
      ];
    }
  }

  void increaseQuantity(int productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId)
          CartItem(
            product: item.product,
            quantity: item.quantity + 1,
          )
        else
          item,
    ];
  }

  void decreaseQuantity(int productId) {
    state = [
      for (final item in state)
        if (item.product.id == productId && item.quantity > 1)
          CartItem(
            product: item.product,
            quantity: item.quantity - 1,
          )
        else
          item,
    ];
  }

  void removeItem(int productId) {
    state = state
        .where((item) => item.product.id != productId)
        .toList();
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(
    0,
    (total, item) => total + item.quantity,
  );
});

final cartTotalPriceProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).fold(
    0.0,
    (total, item) => total + item.totalPrice,
  );
});
