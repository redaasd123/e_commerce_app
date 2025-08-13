import 'package:e_commerce_app/core/save_data/save_data.dart';
import 'package:e_commerce_app/core/utils/api_service.dart';
import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:e_commerce_app/core/utils/sevice_locator.dart';
import 'package:e_commerce_app/feature/home/data/model/e_commerce_model.dart';
import 'package:e_commerce_app/feature/home/domain/entity/product_entity/product_entity.dart';

import '../../domain/entity/cart_entity/cart_entity.dart';
import '../../presentation/views/widget/param/add_product_param.dart';
import '../../presentation/views/widget/param/delete_product_param.dart';
import '../model/cart_model.dart';

abstract class ECommerceDataSource {
  Future<List<CartEntity>> fetchProduct({required int limit, required int skip,});

  Future<CartEntity> addProduct(AddProductParam param);

  Future<CartEntity> deleteProduct(DeleteProductParam param);
}

class ECommerceDataSourceImpl extends ECommerceDataSource {
  @override
  Future<List<CartEntity>> fetchProduct({
    required int limit,
    required int skip,
  }) async {
    List<CartEntity> allCarts = [];
    var result = await getIt<Api>().get(
      endPoint: 'carts',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    for (var cart in result['carts']) {
      List<ProductEntity> products = [];
      for (var item in cart['products']) {
        products.add(ECommerceModel.fromJson(item));
      }

      allCarts.add(CartEntity(id: cart['id'], products: products));
    }
    saveData(allCarts, kCatBox);

    return allCarts;
  }

  @override
  Future<CartEntity> addProduct(AddProductParam param) async {
    var result = await getIt.get<Api>().post(
      endPoint: 'carts/add',
      body: param.toJson(),
    );
    return CartModel.fromJson(result.data);
  }

  @override
  Future<CartEntity> deleteProduct(DeleteProductParam param) async {
    var result = await getIt.get<Api>().put(
      endPoint: 'carts/${param.id}',
      body: param.toJson(),
    );
    return CartModel.fromJson(result.data);
  }
}
