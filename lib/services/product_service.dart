import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  final String _baseUrl = "http://143.198.118.203:8100";

  Future<List<Product>> getProducts() async {
    final uri = Uri.parse("$_baseUrl/ejemplos/product_list_rest/");
    final response = await http.get(uri, headers: {
      "Authorization": "Basic ${base64Encode(utf8.encode('test:test2023'))}"
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar productos");
    }
  }
}
