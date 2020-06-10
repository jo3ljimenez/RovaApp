import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product{
  final int idProduct; 
  final int idTypeProduct;
  final String typeProduct;
  final String name; 
  final String description; 
  final double price; 
  final String urlImage; 
  final bool estatus;

  Product({
    this.idProduct, 
    this.idTypeProduct, 
    this.typeProduct, 
    this.name, 
    this.description, 
    this.price, 
    this.urlImage, 
    this.estatus
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      idProduct: int.parse(json['id_product']),
      idTypeProduct: int.parse(json['id_type_product']),
      typeProduct: json['type_product'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: double.parse(json['price']),
      urlImage: json['url_image'] as String,
      estatus: String.fromEnvironment(json['estatus'] as String) == '1' ? true : false,
    );
  }
}

List<Product> parseProduct(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProduct() async {
  var url = 'http://192.168.1.81/rova/productos/products.php';
  final http.Response response =  await http.get(url);
  return compute(parseProduct, response.body);
}

