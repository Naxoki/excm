import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "http://143.198.118.203:8100";
  final String _username = "test";
  final String _password = "test2023";

  Map<String, String> _headers({bool isJson = false}) {
    return {
      'Authorization': 'Basic ${base64Encode(utf8.encode("$_username:$_password"))}',
      if (isJson) 'Content-Type': 'application/json',
    };
  }

  /// Realiza un GET simple
  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse("$_baseUrl/$endpoint");
    return await http.get(uri, headers: _headers());
  }

  /// Realiza un POST con JSON
  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse("$_baseUrl/$endpoint");
    return await http.post(
      uri,
      headers: _headers(isJson: true),
      body: jsonEncode(data),
    );
  }
}
