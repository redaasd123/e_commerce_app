import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_local_data_source/product_cash_model.dart';
import 'package:hive/hive.dart';
import '../../../domain/entity/cart_entity/cart_entity.dart';
import '../../model/e_commerce_model.dart';

part 'cart_cache_model.g.dart';

@HiveType(typeId: 2)
class CartCacheModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<ProductCacheModel> products; // استخدم الـ CacheModel

  CartCacheModel({required this.id, required this.products});

  // تحويل من CacheModel لـ Entity
  CartEntity toEntity() {
    return CartEntity(
      id: id,
      products: products.map((e) => e.toEntity()).toList(),
    );
  }

  // تحويل من Entity لـ CacheModel
  factory CartCacheModel.fromEntity(CartEntity entity) {
    return CartCacheModel(
      id: entity.id,
      products: entity.products
          .map((e) => ProductCacheModel.fromEntity(e))
          .toList(),
    );
  }

  // تحويل من JSON (لو احتجت)
  factory CartCacheModel.fromJson(Map<String, dynamic> json) {
    return CartCacheModel(
      id: json['id'],
      products: (json['products'] as List)
          .map((e) => ProductCacheModel.fromEntity(ECommerceModel.fromJson(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}
