import 'dart:convert';

import 'package:flutter_sate_management_bloc_cubit/models/product_model.dart';

import '../models/rating_model.dart';

import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProductData() async {
    try{
      final url = Uri.https('fakestoreapi.com', 'products');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final productListJson = jsonDecode(response.body);

        final List<ProductModel> productList = (productListJson as List)
            .map((e) => ProductModel.fromMap(e))
            .toList();
        return productList;
      }else{

        throw Exception("Failed to fetch Data");
      }
    }catch (e){
      print(e);
      throw Exception("Failed to fetch Data");
    }


  }
}
