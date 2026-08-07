import 'package:flutter/material.dart';

import '../models/product.dart';
import '../data/products.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';
import 'product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;

  final Set<int> favoriteIds = {};

  final TextEditingController searchController =
      TextEditingController();

  String searchText = '';

  final List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
  }

  void addToCart(Product product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    setState(() {
      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity++;
      } else {
        cartItems.add(
          CartItem(product: product),
        );
      }

      cartCount = cartItems.fold(
        0,
        (sum, item) => sum + item.quantity,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.title} added to cart!',
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.title
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(
                        cartItems: cartItems,
                      ),
                    ),
                  );
                },
              ),

              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Welcome to MBA Gadgets Store 🛒',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
    const SizedBox(height: 20),
            const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    const SizedBox(height: 12),

SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      categoryItem('Electronics', const Color(0xFF2563EB)),
      categoryItem('Fashion', const Color(0xFFEC4899)),
      categoryItem('Shoes', const Color(0xFFF97316)),
      categoryItem('Watches', const Color(0xFF14B8A6)),
      ],
    ),
  ),

const SizedBox(height: 20),

Expanded(
  child: GridView.builder(
    itemCount: filteredProducts.length,
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 0.62,
    ),
    itemBuilder: (context, index) {
      final product = filteredProducts[index];

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailsPage(
                product: product,
              ),
            ),
          );
        },
        child: Card(
              elevation: 8,
              shadowColor: Colors.black12,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
        ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              product.image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                       ),

                      Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (favoriteIds.contains(product.id)) {
                                favoriteIds.remove(product.id);
                              } else {
                                favoriteIds.add(product.id);
                              }
                            });
                          },
                          icon: Icon(
                            favoriteIds.contains(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteIds.contains(product.id)
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Container(
  padding: const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  ),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    '\$${product.price}',
    style: const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 48, 8, 117),
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {
    addToCart(product);
  },
  child: const Text(
    'Add to Cart',
  ),
),
                  
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }
  Widget categoryItem(String title, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 12),
    padding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
}