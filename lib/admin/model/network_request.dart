import 'dart:convert';
import 'package:flutter/foundation.dart';
import '/admin/model/product.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static var url = Uri.tryParse('https://jsonplaceholder.typicode.com/photos');

  static List<Product> parseProduct(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Product> product =
        list.map((model) => Product.fromJson(model)).toList();
    return product;
  }

  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      return compute(parseProduct, response.body);
    } else {
      throw Exception('Can\'t get photos');
    }
  }
}
