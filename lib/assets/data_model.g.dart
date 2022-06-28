// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListItemAdapter extends TypeAdapter<ListItem> {
  @override
  final int typeId = 0;

  @override
  ListItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListItem(
      name: fields[0] as String?,
      place: fields[1] as String?,
      phone: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ListItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.place)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
