// MODUL V - HTTP Request (class dengan static method)
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poketrek/models/pokemon.dart';

class ApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  /// GET daftar 151 Pokémon generasi pertama
  static Future<List<Pokemon>> getPokemonList({int limit = 151}) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=$limit'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => Pokemon.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat Pokédex (${response.statusCode})');
  }

  /// GET detail satu Pokémon berdasarkan id
  static Future<PokemonDetail> getPokemonDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(jsonDecode(response.body));
    }
    throw Exception('Gagal memuat detail Pokémon (${response.statusCode})');
  }
}
