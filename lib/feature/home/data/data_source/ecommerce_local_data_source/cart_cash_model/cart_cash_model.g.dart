// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_cash_model.dart';

class CartCacheModelAdapter extends TypeAdapter<CartCacheModel> {
  @override
  final int typeId = 2;

  @override
  CartCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartCacheModel(
      id: fields[0] as int,
      products: (fields[1] as List).cast<ProductCacheModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartCacheModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
