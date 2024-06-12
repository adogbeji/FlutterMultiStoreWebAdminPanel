import 'package:flutter/material.dart';

import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.yellow.shade900,
      appBar: AppBar(
        title: const Text('Management'),
      ),
      body: const Text('Dashboard'),);
  }
}