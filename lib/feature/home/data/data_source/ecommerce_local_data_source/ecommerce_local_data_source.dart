import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:hive/hive.dart';

import '../../../domain/entity/cart_entity/cart_entity.dart';
import 'cart_cash_model/cart_cash_model.dart';

abstract class EcommerceLocalDataSource {
  Future<List<CartEntity>> fetchProduct();
  Future<void> saveCarts(List<CartCacheModel> carts);
}

class EcommerceLocalDataSourceImpl extends EcommerceLocalDataSource {
  @override
  Future<List<CartEntity>> fetchProduct() async {
    final box = Hive.box<CartCacheModel>(kCatBox);
    final cachedData = box.values.toList();
    return cachedData.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveCarts(List<CartCacheModel> carts) async {
    final box = Hive.box<CartCacheModel>(kCatBox);
    await box.clear();
    for (var cart in carts) {
      await box.add(cart);
    }
  }
}
