import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _products;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    _products = _productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        final products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final p = products[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading: Image.network(p.image, width: 50, fit: BoxFit.cover),
                title: Text(p.name),
                subtitle: Text("\$${p.price.toStringAsFixed(2)}"),
                onTap: () {
                  // Aquí podríamos navegar a "ver producto"
                },
              ),
            );
          },
        );
      },
    );
  }
}
