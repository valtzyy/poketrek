// MODUL II - Widget reusable untuk tipe Pokémon
import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({super.key, required this.type});

  static const Map<String, Color> _warna = {
    'fire': Colors.orange,
    'water': Colors.blue,
    'grass': Colors.green,
    'electric': Colors.amber,
    'poison': Colors.purple,
    'bug': Colors.lightGreen,
    'flying': Colors.indigo,
    'normal': Colors.grey,
    'ground': Colors.brown,
    'fairy': Colors.pink,
    'psychic': Colors.pinkAccent,
    'fighting': Colors.deepOrange,
    'rock': Colors.blueGrey,
    'ghost': Colors.deepPurple,
    'ice': Colors.cyan,
    'dragon': Colors.indigoAccent,
    'steel': Colors.blueGrey,
    'dark': Colors.black87,
  };

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        type.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
      backgroundColor: _warna[type] ?? Colors.grey,
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
