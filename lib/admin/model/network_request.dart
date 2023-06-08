import 'dart:convert';
import 'package:flutter/foundation.dart';
import '/admin/model/product.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const GET = 'https://owari-1.000webhostapp.com/owari/api.php';
  static var CREATE = 'https://owari-1.000webhostapp.com/owari/add_produk.php';

  static List<Product> parseProduct(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Product> product =
        list.map((model) => Product.fromJson(model)).toList();
    return product;
  }

  static Future<List<Product>> fetchProduct() async {
    final response = await http.get(Uri.parse(GET));
    if (response.statusCode == 200) {
      return compute(parseProduct, response.body);
    } else {
      throw Exception('Can\'t get photos');
    }
  }

  Future<String> addData(Product product) async {
    final response =
        await http.post(Uri.parse(CREATE), body: product.toJsonAdd());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error";
    }
  }
}
