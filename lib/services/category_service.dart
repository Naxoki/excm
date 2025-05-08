import 'dart:convert';
import '../models/category.dart';
import 'api_service.dart';

class CategoryService {
  final ApiService _api = ApiService();

  Future<List<Category>> getCategories() async {
    final response = await _api.get("ejemplos/category_list_rest/");

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json["Listado Categorias"]; // 👈 clave corregida
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception("Error al obtener categorías");
    }
  }


  Future<bool> addCategory(String name) async {
    final response = await _api.post("ejemplos/category_add_rest/", {
      "category_name": name,
    });

    return response.statusCode == 200;
  }

  Future<bool> editCategory({
    required int id,
    required String name,
    String state = "Activa",
  }) async {
    final response = await _api.post("ejemplos/category_edit_rest/", {
      "category_id": id,
      "category_name": name,
      "category_state": state,
    });

    return response.statusCode == 200;
  }

  Future<bool> deleteCategory(int id) async {
    final response = await _api.post("ejemplos/category_del_rest/", {
      "category_id": id,
    });

    return response.statusCode == 200;
  }
}
