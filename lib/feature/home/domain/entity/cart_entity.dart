import 'product_entity.dart';

class CartEntity {
  final int id;
  final List<ProductEntity> products;

  CartEntity({required this.id, required this.products});
}