// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_cash_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCacheModelAdapter extends TypeAdapter<ProductCacheModel> {
  @override
  final int typeId = 3;

  @override
  ProductCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCacheModel(
      id: fields[0] as int,
      title: fields[1] as String,
      thumbnail: fields[2] as String,
      price: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCacheModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
