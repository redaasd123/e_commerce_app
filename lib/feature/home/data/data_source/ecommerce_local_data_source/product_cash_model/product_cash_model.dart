import 'package:hive/hive.dart';
import '../../../../domain/entity/product_entity/product_entity.dart';

part 'product_cash_model.g.dart';

@HiveType(typeId: 3)
class ProductCacheModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String thumbnail;
  @HiveField(3)
  final num price;

  ProductCacheModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  ProductEntity toEntity() =>
      ProductEntity(id: id, title: title, thumbnail: thumbnail, price: price);

  factory ProductCacheModel.fromEntity(ProductEntity entity) =>
      ProductCacheModel(
        id: entity.id,
        title: entity.title,
        thumbnail: entity.thumbnail,
        price: entity.price,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
    };
  }
}
