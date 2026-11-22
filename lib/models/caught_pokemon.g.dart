// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caught_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaughtPokemonAdapter extends TypeAdapter<CaughtPokemon> {
  @override
  final int typeId = 0;

  @override
  CaughtPokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaughtPokemon(
      pokemonId: fields[0] as int,
      name: fields[1] as String,
      nickname: fields[2] as String,
      imageUrl: fields[3] as String,
      spotName: fields[4] as String,
      caughtAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CaughtPokemon obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.pokemonId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nickname)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.spotName)
      ..writeByte(5)
      ..write(obj.caughtAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaughtPokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
