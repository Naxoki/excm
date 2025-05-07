import 'package:flutter/material.dart';
import 'products/product_list_screen.dart';
import 'providers/provider_list_screen.dart';
import 'categories/category_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ProductListScreen(),
    ProviderListScreen(),
    CategoryListScreen(),
  ];

  final List<String> _titles = [
    "Productos",
    "Proveedores",
    "Categorías",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Proveedores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
        ],
      ),
    );
  }
}
