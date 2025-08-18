import 'package:e_commerce_app/core/utils/api_service.dart';
import 'package:e_commerce_app/feature/home/data/data_source/ecommerce_local_data_source/ecommerce_local_data_source.dart';
import 'package:e_commerce_app/feature/home/data/model/e_commerce_model.dart';
import 'package:e_commerce_app/feature/home/data/model/mapper.dart';

import '../../../../../core/utils/sevice_locator.dart';
import '../../../domain/entity/cart_entity/cart_entity.dart';
import '../../../presentation/views/widget/param/add_product_param.dart';
import '../../../presentation/views/widget/param/delete_product_param.dart';
import '../ecommerce_local_data_source/cart_cash_model/cart_cash_model.dart';

abstract class ECommerceDataSource {
  Future<List<CartEntity>> fetchProduct({
    required int limit,
    required int skip,
  });

  Future<CartEntity> addProduct(AddProductParam param);

  Future<CartEntity> deleteProduct(DeleteProductParam param);
}

class ECommerceDataSourceImpl extends ECommerceDataSource {
  final EcommerceLocalDataSource ecommerceLocalDataSource;

  ECommerceDataSourceImpl({required this.ecommerceLocalDataSource});

  @override
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

    for (var cartJson in result['carts']) {
      final cartModel = Carts.fromJson(cartJson);
      allCarts.add(cartModel.toEntity());
    }

    final cacheList = allCarts
        .map((e) => CartCacheModel.fromEntity(e))
        .toList();
    await ecommerceLocalDataSource.saveCarts(cacheList);

    return allCarts;
  }

  @override
  Future<CartEntity> addProduct(AddProductParam param) async {
    await getIt.get<Api>().post(endPoint: 'carts/add', body: param.toJson());

    return CartEntity(id: param.cartId, products: []);
  }

  @override
  Future<CartEntity> deleteProduct(DeleteProductParam param) async {
    await getIt.get<Api>().put(
      endPoint: 'carts/${param.id}',
      body: param.toJson(),
    );
    return CartEntity(id: param.id, products: []);
  }
}
