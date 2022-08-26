// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InComeAdapter extends TypeAdapter<InCome> {
  @override
  final int typeId = 2;

  @override
  InCome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InCome(
      id: fields[0] as String,
      detail: fields[1] as String,
      amount: fields[2] as double,
      timeStamp: fields[3] as DateTime,
      currency: fields[4] as String,
      inCategory: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InCome obj) {
    writer
      ..writeByte(6)
      ..writeByte(5)
      ..write(obj.inCategory)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.detail)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.timeStamp)
      ..writeByte(4)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InComeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
