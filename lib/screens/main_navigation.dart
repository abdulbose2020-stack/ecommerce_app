import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

import 'home_page.dart';
import 'favorites_page.dart';
import 'cart_screen.dart';
import 'profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Product> favoriteProducts = [];
  final List<CartItem> cartItems = [];

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void addToCart(Product product) {
  setState(() {
    final existingItem = cartItems.where(
      (item) => item.product.id == product.id,
    );

    if (existingItem.isNotEmpty) {
      existingItem.first.quantity++;
    } else {
      cartItems.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(
            favoriteProducts: favoriteProducts,
            onFavoriteChanged: toggleFavorite,
            onAddToCart: addToCart,
            cartCount: cartItems.length,
          ),

          FavoritesPage(
            favoriteProducts: favoriteProducts,
          ),

          CartScreen(
            cartItems: cartItems,
          ),

          const ProfilePage(),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,

            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            type: BottomNavigationBarType.fixed,

            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,

            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}