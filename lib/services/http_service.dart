import 'dart:convert';

import 'package:fake_store/models/product_model.dart';
import 'package:fake_store/models/rate_model.dart';
import 'package:http/http.dart' as http;
import 'package:fake_store/models/categories_model.dart';

class HttpService {
  final String baseUrl = "https://fakestoreapi.com/";
  final String categoriesRoute = "products/categories/";
  final String allProductsRoute = "products";
  final String categoryProductsRoute = "products/category/";
  final String oneProductRoute = "products/";

  Future<List<CategoryModel>> getCategories() async {
    final url = Uri.parse(baseUrl + categoriesRoute);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final categories = json.map((e) => CategoryModel(e, false)).toList();
      return categories;
    } else {
      print("Error: ${response.body}");
      return [];
    }
  }

  Future<List<ProductModel>> getProducts(String route) async {
    final uri = route == "products/category/All" ? allProductsRoute : route;
    print("Route: $route");
    final url = Uri.parse(baseUrl + uri);
    print("Url: $url");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final products = json.map((e) {
        return ProductModel(
            e["id"],
            e["title"],
            double.parse(e["price"].toString()),
            e["description"],
            e["category"],
            e["image"]);
      }).toList();
      return products;
    } else {
      print("Error: ${response.body}");
      return [];
    }
  }

  Future<ProductModel> getSingleProduct(int id) async {
    final url = Uri.parse("$baseUrl$oneProductRoute$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel(jsonMap["id"], jsonMap["title"], double.parse(jsonMap["price"].toString()),
          jsonMap["description"], jsonMap["category"], jsonMap["image"]);
    }
    return ProductModel(-1, "empty", 0.0, "empty", "empty", "empty");
  }
}
