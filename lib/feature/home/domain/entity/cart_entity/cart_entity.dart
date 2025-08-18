import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../product_entity/product_entity.dart';



class CartEntity extends Equatable {
  final int id;
  final List<ProductEntity> products;

  CartEntity({required this.id, required this.products});

  @override
  List<Object?> get props => [id, products];
}
