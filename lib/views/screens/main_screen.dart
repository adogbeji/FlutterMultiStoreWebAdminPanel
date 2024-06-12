import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text('Management'),
      ),
      sideBar: const SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Vendors',
            icon: CupertinoIcons.person_3,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            icon: CupertinoIcons.money_dollar,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Orders',
            icon: CupertinoIcons.shopping_cart,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Products',
            icon: Icons.shop,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            icon: CupertinoIcons.add,
            route: '/',
          ),
        ],
        selectedRoute: '',
      ),
      body: const Text('Dashboard'),
    );
  }
}
