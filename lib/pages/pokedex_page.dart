// MODUL II (GridView) + MODUL V (data API) + MODUL VIII (Obx)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poketrek/controllers/pokedex_controller.dart';
import 'package:poketrek/pages/detail_page.dart';
import 'package:poketrek/widgets/pokemon_card.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PokedexController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (c.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(c.errorMessage.value, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: c.fetchPokemon, child: const Text('Coba lagi')),
              ],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: c.pokemonList.length,
          itemBuilder: (context, index) {
            final pokemon = c.pokemonList[index];
            return PokemonCard(
              pokemon: pokemon,
              // Modul IV - push + passing data (id & nama)
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(id: pokemon.id, name: pokemon.displayName),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
