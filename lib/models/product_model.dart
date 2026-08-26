// {
// id: 1,
// title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
// price: 109.95,
// description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
// category: "men's clothing",
// image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
// rating: {
// rate: 3.9,
// count: 120
// }
// },

import 'package:flutter_sate_management_bloc_cubit/models/rating_model.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final RatingModel rate;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rate': rate,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: map['price'] as num,
      description: map['description'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      rate: RatingModel.fromMap(map["rating"]as Map<String,dynamic>) ,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, price, description, category, image, rate];
}
