// MODUL VIII (GetX state management) + MODUL VI (CRUD Hive)
// Satu sumber data koleksi -> badge di BottomNav, halaman Koleksi,
// dan halaman Profil otomatis sinkron tanpa passing data / setState.
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poketrek/models/caught_pokemon.dart';

class KoleksiController extends GetxController {
  final Box<CaughtPokemon> _box = Hive.box<CaughtPokemon>('koleksi');
  final koleksi = <CaughtPokemon>[].obs;

  int get jumlah => koleksi.length;

  @override
  void onInit() {
    super.onInit();
    _muatUlang();
  }

  void _muatUlang() => koleksi.assignAll(_box.values.toList());

  // CREATE
  Future<void> tangkap(CaughtPokemon pokemon) async {
    await _box.add(pokemon);
    _muatUlang();
  }

  // UPDATE
  Future<void> gantiNickname(int index, String nicknameBaru) async {
    final lama = _box.getAt(index)!;
    await _box.putAt(
      index,
      CaughtPokemon(
        pokemonId: lama.pokemonId,
        name: lama.name,
        nickname: nicknameBaru,
        imageUrl: lama.imageUrl,
        spotName: lama.spotName,
        caughtAt: lama.caughtAt,
      ),
    );
    _muatUlang();
  }

  // DELETE
  Future<void> lepaskan(int index) async {
    await _box.deleteAt(index);
    _muatUlang();
  }
}
