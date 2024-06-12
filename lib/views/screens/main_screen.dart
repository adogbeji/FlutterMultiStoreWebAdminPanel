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
            title: 'Categories',
            icon: Icons.category,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: '/',
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: '/',
          ),
        ],
        selectedRoute: '',
      ),
      body: const Text('Dashboard'),
    );
  }
}
