import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../Model/Filter_model.dart';
import '../Model/shopping_model.dart';

String url = 'https://api.escuelajs.co/api/v1/products';

String filterURl = 'https://api.escuelajs.co/api/v1/products/?title=Generic';


List<ShoppingModels> shop = [];

String selectedCategory = 'All';


List<ShoppingFliterModels> FilterShop = [];

Future<List<ShoppingModels>> fetchShoppingData() async {
  try {
    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      shop.clear();

      for (Map<String, dynamic> item in data) {
        shop.add(ShoppingModels.fromJson(item));
      }

      return shop;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}

Future<List<ShoppingFliterModels>> fetchFliterShoppingData() async {
  try {
    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      FilterShop.clear();

      for (Map<String, dynamic> item in data) {
        FilterShop.add(ShoppingFliterModels.fromJson(item));
      }

      return FilterShop;
    } else {
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}

