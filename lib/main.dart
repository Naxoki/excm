import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products/product_form_screen.dart';
import 'screens/providers/provider_form_screen.dart';
import 'screens/categories/category_form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/product-form': (context) => ProductFormScreen(),
        '/provider-form': (context) => ProviderFormScreen(),
        '/category-form': (context) => CategoryFormScreen(),

        // Puedes agregar más rutas aquí como: '/provider-edit': ...
      },
    );
  }
}
