import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Fatima AND Mahnooray12"),
            // Replace with actual user name
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/profile.jpg"), // Use an actual image
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 159, 79, 167),
            ),
            accountEmail: null,
          ),
          _buildDrawerItem(Icons.monetization_on, "Earn with Us", context),
          _buildDrawerItem(Icons.person, "Profile", context),
          _buildDrawerItem(Icons.settings, "Settings", context),
          _buildDrawerItem(Icons.history, "Order History", context),
          _buildDrawerItem(Icons.star, "Ratings & Reviews", context),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 159, 79, 167)),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        // TODO: Navigate to the respective screen
      },
    );
  }
}
