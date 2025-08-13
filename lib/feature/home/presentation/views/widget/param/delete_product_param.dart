import 'package:e_commerce_app/feature/home/domain/entity/product_entity/product_entity.dart';

class DeleteProductParam{
  final int id;
  final List<ProductEntity> product;
  DeleteProductParam({required this.id, required this.product});
  Map<String,dynamic> toJson(){
    return{
      "merge": true,
      "products":product.map((product)=>product.toJson()).toList(),
    };
  }
}