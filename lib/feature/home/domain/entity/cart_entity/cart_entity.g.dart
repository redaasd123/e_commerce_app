// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartEntityAdapter extends TypeAdapter<CartEntity> {
  @override
  final int typeId = 0;

  @override
  CartEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartEntity(
      id: fields[0] as int,
      products: (fields[1] as List).cast<ProductEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartEntity obj) {
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
      other is CartEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
