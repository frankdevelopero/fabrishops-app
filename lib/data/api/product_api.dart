import 'dart:io';
import 'package:fabrishop/data/models/category.dart';
import 'package:fabrishop/data/models/product.dart';
import 'package:fabrishop/ui/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductApi {
  Future<List<Category>> getHome({
    @required int store,
  }) async {
    final url = "${ApiConstants.domain}api/v1/store/" + store.toString();
    print(url);
    final response = await http
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    List<Category> listCategory = [];
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      print(parsed);
      final List data = parsed["data"];
      for (int x = 0; x < data.length; x++) {
        final id = data[x]['id'] as int;
        final name = data[x]['name'] as String;
        final description = data[x]['description'] as String;
        final List productData = data[x]['products'];
        List<Product> products = [];
        for (int y = 0; y < productData.length; y++) {
          final prodName = productData[y]['name'] as String;
          final prodDescription = productData[y]['description'] as String;
          final prodPrice = productData[y]['price'] as double;
          final prodImage = productData[y]['image'] as String;
          print(prodImage);
          Product product = Product(
              name: prodName,
              description: prodDescription,
              price: prodPrice,
              image: "http://192.168.0.17:8000" + prodImage,
              store: 1,
              category: id);
          products.add(product);
        }
        Category category = Category(
          id: id,
          name: name,
          description: description,
          products: products,
        );
        listCategory.add(category);
      }
    }
    return listCategory;
  }

  Future<bool> createProduct(Product product, List<File> files) async {
    final url = "${ApiConstants.domain}api/v1/product/add";
    List<String> images = [];
    for (File xfile in files) {
      var image64 = "";
      if (xfile != null) {
        List<int> imageBytes = xfile.readAsBytesSync();
        image64 = base64Encode(imageBytes);
        images.add(image64);
      }
    }
    final body = jsonEncode({
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "category": product.category,
      "images": images,
      "store": product.store,
    });

    print(body);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.statusCode);
    final parsed = jsonDecode(response.body);
    print(parsed);
    if (response.statusCode == 200) {
      return true;
      /*
      final status = parsed['status'] as bool;
      if (status) {
        
      }
      */
    } else {
      return false;
    }
  }
}
