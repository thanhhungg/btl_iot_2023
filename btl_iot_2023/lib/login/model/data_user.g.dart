// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataUserAdapter extends TypeAdapter<DataUser> {
  @override
  final int typeId = 0;

  @override
  DataUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataUser(
      name: fields[0] as String?,
      lcNumber: fields[1] as String?,
      age: fields[2] as int?,
      email: fields[3] as String?,
      account: fields[4] as String?,
      password: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lcNumber)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.account)
      ..writeByte(5)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
