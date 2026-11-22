// MODUL II - Card untuk item GridView Pokédex
import 'package:flutter/material.dart';
import 'package:poketrek/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(pokemon.nomor, style: const TextStyle(color: Colors.grey)),
              ),
              Expanded(
                child: Image.network(
                  pokemon.imageUrl,
                  errorBuilder: (context, error, stack) =>
                      const Icon(Icons.catching_pokemon, size: 64),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pokemon.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
