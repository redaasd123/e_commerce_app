import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 1)
class ProductEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnail;

  @HiveField(3)
  final num price;

  ProductEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  factory ProductEntity.empty() {
    return ProductEntity(id: -1, title: '', thumbnail: '', price: 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'thumbnail': thumbnail, 'price': price};
  }
}
