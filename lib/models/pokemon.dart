// MODUL I (OOP) + MODUL V (factory constructor fromJson)

/// Data ringkas untuk list Pokédex (dari endpoint /pokemon?limit=151).
class Pokemon {
  final int _id;
  final String _name;

  Pokemon({required int id, required String name})
      : _id = id,
        _name = name;

  int get id => _id;
  String get name => _name;
  String get displayName => _name[0].toUpperCase() + _name.substring(1);
  String get nomor => '#${_id.toString().padLeft(3, '0')}';
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$_id.png';

  /// API list hanya memberi name + url, id diambil dari ujung url.
  /// contoh url: https://pokeapi.co/api/v2/pokemon/25/
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final segments = (json['url'] as String)
        .split('/')
        .where((s) => s.isNotEmpty)
        .toList();
    return Pokemon(id: int.parse(segments.last), name: json['name']);
  }
}

/// Data lengkap untuk halaman detail -> INHERITANCE dari Pokemon.
class PokemonDetail extends Pokemon {
  final List<String> types;
  final int height; // satuan desimeter
  final int weight; // satuan hektogram
  final Map<String, int> stats;

  PokemonDetail({
    required super.id,
    required super.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
  });

  double get tinggiMeter => height / 10;
  double get beratKg => weight / 10;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      height: json['height'],
      weight: json['weight'],
      stats: {
        for (final s in json['stats'] as List)
          s['stat']['name'] as String: s['base_stat'] as int,
      },
    );
  }
}
