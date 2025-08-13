import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:hive/hive.dart';

import '../../domain/entity/cart_entity/cart_entity.dart';

abstract class EcommerceLocalDataSource {
  List<CartEntity> fetchProduct();
}

class EcommerceLocalDataSourceImpl extends EcommerceLocalDataSource {
  @override
  List<CartEntity> fetchProduct() {
    final box = Hive.box<CartEntity>(kCatBox);
    return box.values.toList();
  }
}
