import 'package:e_commerce_app/feature/home/domain/entity/product_entity/product_entity.dart';

class ECommerceModel extends ProductEntity {
  final List<Carts>? carts;
  final double? total;
  final int? skip;
  final int? limit;

  ECommerceModel({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
    required int id,
    required String title,
    required String thumbnail,
    required num price,
  }) : super(id: id, title: title, thumbnail: thumbnail, price: price);

  factory ECommerceModel.fromJson(Map<String, dynamic> json) {
    return ECommerceModel(
      price: json['price'],
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      carts: (json['carts'] as List<dynamic>?)
          ?.map((v) => Carts.fromJson(v))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  ECommerceModel copyWith({
    List<Carts>? carts,
    double? total,
    int? skip,
    int? limit,
  }) {
    return ECommerceModel(
      price: price,
      id: id,
      title: title,
      thumbnail: thumbnail,
      carts: carts ?? this.carts,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'carts': carts?.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}


/// id : 1
/// products : [{"id":168,"title":"Charger SXT RWD","price":32999.99,"quantity":3,"total":98999.97,"discountPercentage":13.39,"discountedTotal":85743.87,"thumbnail":"https://cdn.dummyjson.com/products/images/vehicle/Charger%20SXT%20RWD/thumbnail.png"},{"id":78,"title":"Apple MacBook Pro 14 Inch Space Grey","price":1999.99,"quantity":2,"total":3999.98,"discountPercentage":18.52,"discountedTotal":3259.18,"thumbnail":"https://cdn.dummyjson.com/products/images/laptops/Apple%20MacBook%20Pro%2014%20Inch%20Space%20Grey/thumbnail.png"},{"id":183,"title":"Green Oval Earring","price":24.99,"quantity":5,"total":124.94999999999999,"discountPercentage":6.28,"discountedTotal":117.1,"thumbnail":"https://cdn.dummyjson.com/products/images/womens-jewellery/Green%20Oval%20Earring/thumbnail.png"},{"id":100,"title":"Apple Airpods","price":129.99,"quantity":5,"total":649.95,"discountPercentage":12.84,"discountedTotal":566.5,"thumbnail":"https://cdn.dummyjson.com/products/images/mobile-accessories/Apple%20Airpods/thumbnail.png"}]
/// total : 103774.85
/// discountedTotal : 89686.65
/// userId : 33
/// totalProducts : 4
/// totalQuantity : 15

class Carts {
  Carts({
      this.id, 
      this.products, 
      this.total, 
      this.discountedTotal, 
      this.userId, 
      this.totalProducts, 
      this.totalQuantity,});

  Carts.fromJson(dynamic json) {
    id = json['id'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    discountedTotal = json['discountedTotal'];
    userId = json['userId'];
    totalProducts = json['totalProducts'];
    totalQuantity = json['totalQuantity'];
  }
  int? id;
  List<Products>? products;
  num? total;
  num? discountedTotal;
  num? userId;
  num? totalProducts;
  num? totalQuantity;
Carts copyWith({  int? id,
  List<Products>? products,
  num? total,
  num? discountedTotal,
  num? userId,
  num? totalProducts,
  num? totalQuantity,
}) => Carts(  id: id ?? this.id,
  products: products ?? this.products,
  total: total ?? this.total,
  discountedTotal: discountedTotal ?? this.discountedTotal,
  userId: userId ?? this.userId,
  totalProducts: totalProducts ?? this.totalProducts,
  totalQuantity: totalQuantity ?? this.totalQuantity,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['discountedTotal'] = discountedTotal;
    map['userId'] = userId;
    map['totalProducts'] = totalProducts;
    map['totalQuantity'] = totalQuantity;
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.title, 
      this.price, 
      this.quantity, 
      this.total, 
      this.discountPercentage, 
      this.discountedTotal, 
      this.thumbnail,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage'];
    discountedTotal = json['discountedTotal'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? title;
  num? price;
  num? quantity;
  num? total;
  num? discountPercentage;
  num? discountedTotal;
  String? thumbnail;
Products copyWith({  int? id,
  String? title,
  num? price,
  num? quantity,
  num? total,
  num? discountPercentage,
  num? discountedTotal,
  String? thumbnail,
}) => Products(  id: id ?? this.id,
  title: title ?? this.title,
  price: price ?? this.price,
  quantity: quantity ?? this.quantity,
  total: total ?? this.total,
  discountPercentage: discountPercentage ?? this.discountPercentage,
  discountedTotal: discountedTotal ?? this.discountedTotal,
  thumbnail: thumbnail ?? this.thumbnail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['quantity'] = quantity;
    map['total'] = total;
    map['discountPercentage'] = discountPercentage;
    map['discountedTotal'] = discountedTotal;
    map['thumbnail'] = thumbnail;
    return map;
  }

}