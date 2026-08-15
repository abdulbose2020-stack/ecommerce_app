import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartScreen({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return CartPage(cartItems: cartItems);
  }
}