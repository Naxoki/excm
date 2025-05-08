import 'dart:convert';
import '../models/provider.dart';
import 'api_service.dart';

class ProviderService {
  final ApiService _api = ApiService();

  Future<List<Provider>> getProviders() async {
    final response = await _api.get("ejemplos/provider_list_rest/");

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> data = json["Proveedores Listado"];
      return data.map((item) => Provider.fromJson(item)).toList();
    } else {
      throw Exception("Error al obtener proveedores");
    }
  }
  Future<bool> addProvider({
  required String name,
  required String lastName,
  required String email,
  String state = "Activo",
  }) async {
    final response = await _api.post("ejemplos/provider_add_rest/", {
      "provider_name": name,
      "provider_last_name": lastName,
      "provider_mail": email,
      "provider_state": state,
    });

    return response.statusCode == 200;
  }   

  Future<bool> editProvider({
  required int id,
  required String name,
  required String lastName,
  required String email,
  String state = "Activo",
  }) async {
    final response = await _api.post("ejemplos/provider_edit_rest/", {
      "provider_id": id,
      "provider_name": name,
      "provider_last_name": lastName,
      "provider_mail": email,
      "provider_state": state,
    });

    return response.statusCode == 200;
  }

  Future<bool> deleteProvider(int id) async {
  final response = await _api.post("ejemplos/provider_del_rest/", {
    "provider_id": id,
  });

    return response.statusCode == 200;
  }

}
