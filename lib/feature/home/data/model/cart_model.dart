import 'package:e_commerce_app/feature/home/data/model/e_commerce_model.dart';

import '../../domain/entity/cart_entity/cart_entity.dart';
import '../../domain/entity/product_entity/product_entity.dart';

class CartModel extends CartEntity {
  CartModel({required int id, required List<ProductEntity> products})
      : super(id: id, products: products);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      products: (json['products'] as List)
          .map((e) => ECommerceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((e) => (e as ECommerceModel).toJson()).toList(),
    };
  }
}
