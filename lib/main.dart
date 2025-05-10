import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/products/product_form_screen.dart';
import 'screens/providers/provider_form_screen.dart';
import 'screens/categories/category_form_screen.dart';
import 'screens/categories/category_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excm App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/product-form': (context) => ProductFormScreen(),
        '/provider-form': (context) => ProviderFormScreen(),
        '/category-form': (context) => CategoryFormScreen(),
        '/category-list': (context) => CategoryListScreen(),
      },
    );
  }
}
