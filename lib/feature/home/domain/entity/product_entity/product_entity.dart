import 'package:equatable/equatable.dart';



class ProductEntity extends Equatable {
  final int id;

  final String title;

  final String thumbnail;

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

  @override
  List<Object?> get props => [id, title, thumbnail, price];
}
