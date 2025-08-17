import 'package:e_commerce_app/feature/home/data/model/e_commerce_model.dart';
import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:e_commerce_app/feature/home/domain/entity/product_entity/product_entity.dart';

extension CartMapper on Carts {
  CartEntity toEntity() {
    return CartEntity(
      id: id ?? 1,
      products: products?.map((p)=>p.toEntity()).toList()??[],
    );

  }
}

extension ProductMapper on Products {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? 1,
      title: title ?? '',
      thumbnail: thumbnail ?? '',
      price: price ?? 10,
    );
  }
}
