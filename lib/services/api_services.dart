import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = 'https://fakestoreapi.com';

  static Future<List<String>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/products/categories'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('$_baseUrl/products?limit=50'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/products/category/$category'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load products for category: $category');
    }
  }
}
