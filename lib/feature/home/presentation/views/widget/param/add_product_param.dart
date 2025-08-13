
import '../../../../domain/entity/product_entity/product_entity.dart';

class AddProductParam {
  final int cartId;
  final List<ProductEntity> products;

  AddProductParam({required this.cartId, required this.products});
  Map<String, dynamic> toJson() {
    return {
      'userId': cartId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}