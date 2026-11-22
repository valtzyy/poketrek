// MODUL I - OOP: Encapsulation, Inheritance, Polymorphism

/// Class induk untuk semua lokasi di peta.
/// Field dibuat private (_) lalu dibuka lewat getter -> ENCAPSULATION.
class Lokasi {
  final String _nama;
  final double _latitude;
  final double _longitude;

  Lokasi({
    required String nama,
    required double latitude,
    required double longitude,
  })  : _nama = nama,
        _latitude = latitude,
        _longitude = longitude;

  String get nama => _nama;
  double get latitude => _latitude;
  double get longitude => _longitude;

  /// Bisa ditangkap atau tidak. Di-override oleh class anak.
  bool get bisaDitangkap => false;

  /// Akan di-override oleh class anak -> POLYMORPHISM.
  String deskripsi() => 'Sebuah lokasi di sekitar kampus';
}

/// Titik tempat Pokémon liar muncul -> INHERITANCE dari Lokasi.
class SpawnSpot extends Lokasi {
  final int pokemonId;

  SpawnSpot({
    required super.nama,
    required super.latitude,
    required super.longitude,
    required this.pokemonId,
  });

  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';

  @override
  bool get bisaDitangkap => true;

  @override
  String deskripsi() => 'Ada Pokémon liar bersembunyi di sini!';
}

/// Tempat istirahat, tidak ada Pokémon -> INHERITANCE dari Lokasi.
class PokeCenter extends Lokasi {
  PokeCenter({
    required super.nama,
    required super.latitude,
    required super.longitude,
  });

  @override
  String deskripsi() => 'PokéCenter: tempat istirahat para trainer';
}
