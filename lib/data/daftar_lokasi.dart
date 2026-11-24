// MODUL VII - Data dummy lokasi (seperti data/locations.dart di modul)
import 'package:poketrek/models/lokasi.dart';

// TODO: GANTI koordinat di bawah dengan titik asli di kampus kalian.
// Caranya: buka Google Maps -> klik kanan titik -> klik angka koordinatnya (otomatis tersalin).
final List<Lokasi> daftarLokasi = [
  SpawnSpot(nama: 'Perpustakaan', latitude: -7.761878119391824, longitude: 110.40992535640783, pokemonId: 25),   // Pikachu
  SpawnSpot(nama: 'Kantin', latitude: -7.76290, longitude: 110.40920, pokemonId: 143),        // Snorlax
  SpawnSpot(nama: 'Lapangan', latitude: -7.762779028562256, longitude: 110.40910960331594, pokemonId: 4),        // Charmander
  SpawnSpot(nama: 'Gedung Rektorat', latitude: -7.761913999515676, longitude: 110.40935136424784, pokemonId: 1), // Bulbasaur
  SpawnSpot(nama: 'Parkiran', latitude: -7.763212221821174, longitude: 110.41153163806372, pokemonId: 7),        // Squirtle
  SpawnSpot(nama: 'Gerbang Utama', latitude: -7.761203051796961, longitude: 110.40964872733167, pokemonId: 133), // Eevee
  PokeCenter(nama: 'Gazebo Tengah', latitude: -7.762516935265564, longitude: 110.4081315469369),
];
