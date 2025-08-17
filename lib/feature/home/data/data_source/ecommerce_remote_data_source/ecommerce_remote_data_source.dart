import 'package:e_commerce_app/core/save_data/save_data.dart';
import 'package:e_commerce_app/core/utils/api_service.dart';
import 'package:e_commerce_app/core/utils/constance..dart';
import 'package:e_commerce_app/feature/home/data/model/e_commerce_model.dart';
import 'package:e_commerce_app/feature/home/data/model/mapper.dart';
import 'package:e_commerce_app/feature/home/domain/entity/product_entity/product_entity.dart';

import '../../../../../core/utils/sevice_locator.dart';
import '../../../domain/entity/cart_entity/cart_entity.dart';
import '../../../presentation/views/widget/param/add_product_param.dart';
import '../../../presentation/views/widget/param/delete_product_param.dart';
import '../../model/cart_model.dart';
import '../ecommerce_local_data_source/cart_cash_model.dart';

abstract class ECommerceDataSource {
  Future<List<CartEntity>> fetchProduct({required int limit, required int skip,});

  Future<CartEntity> addProduct(AddProductParam param);

  Future<CartEntity> deleteProduct(DeleteProductParam param);
}

class ECommerceDataSourceImpl extends ECommerceDataSource {
  @override
  @override
  Future<List<CartEntity>> fetchProduct({
    required int limit,
    required int skip,
  }) async {
    List<CartEntity> allCarts = [];

    // جلب البيانات من API
    var result = await getIt<Api>().get(
      endPoint: 'carts',
      queryParameters: {'limit': limit, 'skip': skip},
    );

    for (var cartJson in result['carts']) {
      final cartModel = Carts.fromJson(cartJson); // Model من Data Layer
      allCarts.add(cartModel.toEntity());        // تحويل لـ Entity
    }

    // **تخزين البيانات في Hive باستخدام CartCacheModel**
    final cacheList = allCarts.map((e) => CartCacheModel.fromEntity(e)).toList();
    saveData(cacheList, kCatBox); // هنا saveData لازم يقبل CartCacheModel

    return allCarts;
  }


  @override
  Future<CartEntity> addProduct(AddProductParam param) async {
    await getIt.get<Api>().post(
      endPoint: 'carts/add',
      body: param.toJson(),
    );

    // لو مش محتاج ترجّع أي حاجة كاملة من السيرفر
    return CartEntity(id: param.cartId, products: []); // أو أي Entity مختصر
  }

  @override
  Future<CartEntity> deleteProduct(DeleteProductParam param) async {
    await getIt.get<Api>().put(
      endPoint: 'carts/${param.id}',
      body: param.toJson(),
    );

    // لو مش محتاج ترجّع أي حاجة كاملة
    return CartEntity(id: param.id, products: []);
  }

}


//Future<List<CartEntity>> fetchProduct({
//     required int limit,
//     required int skip,
//   }) async {
//     List<CartEntity> allCarts = [];
//     var result = await getIt<Api>().get(
//       endPoint: 'carts',
//       queryParameters: {'limit': limit, 'skip': skip},
//     );
//     for (var cart in result['carts']) {
//       List<ProductEntity> products = [];
//       for (var item in cart['products']) {
//         products.add(ECommerceModel.fromJson(item));
//       }
//
//       allCarts.add(CartEntity(id: cart['id'], products: products));
//     }
//     saveData(allCarts, kCatBox);
//
//     return allCarts;
//   }