import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget buildMenuItem(
    IconData icon,
    String title,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            Image.asset(
  "assets/images/Bose.jpeg",
  width: 200,
  height: 200,
),

            const SizedBox(height: 15),

            const Text(
              "Al'ameen Bose",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "CEO @ MBA Comm.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            buildMenuItem(Icons.shopping_bag, "My Orders"),
            buildMenuItem(Icons.favorite, "Wishlist"),
            buildMenuItem(Icons.location_on, "Shipping Address"),
            buildMenuItem(Icons.payment, "Payment Methods"),
            buildMenuItem(Icons.settings, "Settings"),
            buildMenuItem(Icons.help, "Help & Support"),
            buildMenuItem(Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }
}