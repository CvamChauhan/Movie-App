// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterDataAdapter extends TypeAdapter<RegisterData> {
  @override
  final int typeId = 1;

  @override
  RegisterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterData(
      firstName: fields[0] as String,
      secondName: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
      mobile: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.secondName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.mobile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
