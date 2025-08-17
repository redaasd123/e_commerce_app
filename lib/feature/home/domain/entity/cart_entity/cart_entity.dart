import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../product_entity/product_entity.dart';

part 'cart_entity.g.dart';

@HiveType(typeId: 0)
class CartEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final List<ProductEntity> products;

  CartEntity({required this.id, required this.products});

  @override
  List<Object?> get props => [id, products];
}
