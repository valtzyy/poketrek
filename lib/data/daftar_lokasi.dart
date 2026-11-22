// MODUL VII - Data dummy lokasi (seperti data/locations.dart di modul)
import 'package:poketrek/models/lokasi.dart';

// TODO: GANTI koordinat di bawah dengan titik asli di kampus kalian.
// Caranya: buka Google Maps -> klik kanan titik -> klik angka koordinatnya (otomatis tersalin).
final List<Lokasi> daftarLokasi = [
  SpawnSpot(nama: 'Perpustakaan', latitude: -7.76210, longitude: 110.40850, pokemonId: 25),   // Pikachu
  SpawnSpot(nama: 'Kantin', latitude: -7.76290, longitude: 110.40920, pokemonId: 143),        // Snorlax
  SpawnSpot(nama: 'Lapangan', latitude: -7.76150, longitude: 110.40980, pokemonId: 4),        // Charmander
  SpawnSpot(nama: 'Gedung Rektorat', latitude: -7.76330, longitude: 110.40780, pokemonId: 1), // Bulbasaur
  SpawnSpot(nama: 'Parkiran', latitude: -7.76080, longitude: 110.40870, pokemonId: 7),        // Squirtle
  SpawnSpot(nama: 'Gerbang Utama', latitude: -7.76400, longitude: 110.40900, pokemonId: 133), // Eevee
  PokeCenter(nama: 'Gazebo Tengah', latitude: -7.76240, longitude: 110.40890),
];
