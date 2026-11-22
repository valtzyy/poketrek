// MODUL VI - Hive: model HiveObject yang disimpan di box 'koleksi'
import 'package:hive_flutter/hive_flutter.dart';

part 'caught_pokemon.g.dart';

@HiveType(typeId: 0)
class CaughtPokemon extends HiveObject {
  @HiveField(0)
  final int pokemonId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String nickname;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String spotName;

  @HiveField(5)
  final DateTime caughtAt;

  CaughtPokemon({
    required this.pokemonId,
    required this.name,
    required this.nickname,
    required this.imageUrl,
    required this.spotName,
    required this.caughtAt,
  });
}
