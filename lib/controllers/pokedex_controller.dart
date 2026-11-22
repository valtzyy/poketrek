// MODUL VIII - GetX Controller: memisahkan logika (ambil data API) dari UI
import 'package:get/get.dart';
import 'package:poketrek/models/pokemon.dart';
import 'package:poketrek/services/api_service.dart';

class PokedexController extends GetxController {
  final pokemonList = <Pokemon>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    try {
      isLoading(true);
      errorMessage('');
      pokemonList.assignAll(await ApiService.getPokemonList());
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
