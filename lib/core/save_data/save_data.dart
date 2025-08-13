import 'package:e_commerce_app/feature/home/domain/entity/cart_entity/cart_entity.dart';
import 'package:hive/hive.dart';

void saveData(List<CartEntity> data, String boxName) {
  var box = Hive.box<CartEntity>(boxName);
  box.clear();
  box.addAll(data);
}