import 'package:equatable/equatable.dart';

import '../product_entity/product_entity.dart';



class CartEntity extends Equatable {
  final int id;
  final List<ProductEntity> products;

 const CartEntity({required this.id, required this.products});

  @override
  List<Object?> get props => [id, products];
}
