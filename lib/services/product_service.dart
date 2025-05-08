import 'dart:convert';
import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  final ApiService _api = ApiService();

  Future<List<Product>> getProducts() async {
    final response = await _api.get("ejemplos/product_list_rest/");

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List<dynamic> data = json["Listado"];

      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Error al obtener productos");
    }
  }


  Future<bool> addProduct(String name, double price, String imageUrl) async {
    final response = await _api.post("ejemplos/product_add_rest/", {
      "product_name": name,
      "product_price": price,
      "product_image": imageUrl,
    });
    return response.statusCode == 200;
  }

  Future<bool> editProduct({
    required int id,
    required String name,
    required double price,
    required String imageUrl,
  }) async {
    final response = await _api.post("ejemplos/product_edit_rest/", {
      "product_id": id,
      "product_name": name,
      "product_price": price,
      "product_image": imageUrl,
      "product_state": "Activo"
    });
    return response.statusCode == 200;
  }

  Future<bool> deleteProduct(int id) async {
    final response = await _api.post("ejemplos/product_del_rest/", {
      "product_id": id,
    });
    return response.statusCode == 200;
  }
}
