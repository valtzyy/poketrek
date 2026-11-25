// MODUL V - FutureBuilder + MODUL II - SingleChildScrollView
import 'package:flutter/material.dart';
import 'package:poketrek/models/pokemon.dart';
import 'package:poketrek/services/api_service.dart';
import 'package:poketrek/widgets/type_chip.dart';

class DetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String? nickname; // diisi kalau dibuka dari Tas Koleksi

  const DetailPage({super.key, required this.id, required this.name, this.nickname});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<PokemonDetail> _futureDetail;

  static const Map<String, String> _labelStat = {
    'hp': 'HP',
    'attack': 'Attack',
    'defense': 'Defense',
    'special-attack': 'Sp. Atk',
    'special-defense': 'Sp. Def',
    'speed': 'Speed',
  };

  /// "Dudung (Charmander)" kalau sudah diberi nickname, selain itu cukup "Charmander"
  String _judul(String spesies) {
    final nick = widget.nickname;
    if (nick == null || nick == spesies) return spesies;
    return '$nick ($spesies)';
  }

  @override
  void initState() {
    super.initState();
    _futureDetail = ApiService.getPokemonDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_judul(widget.name))),
      body: FutureBuilder<PokemonDetail>(
        future: _futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat: ${snapshot.error}'));
          }

          final p = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(p.imageUrl, height: 220),
                Text(p.nomor, style: const TextStyle(color: Colors.grey, fontSize: 16)),
                Text(
                  _judul(p.displayName),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: p.types.map((t) => TypeChip(type: t)).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _infoBox('Tinggi', '${p.tinggiMeter} m', Icons.height),
                    const SizedBox(width: 12),
                    _infoBox('Berat', '${p.beratKg} kg', Icons.monitor_weight),
                  ],
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Base Stats',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...p.stats.entries.map((s) => _statRow(s.key, s.value)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoBox(String label, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon),
              Text(label, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statRow(String nama, int nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 72, child: Text(_labelStat[nama] ?? nama)),
          SizedBox(width: 36, child: Text('$nilai', style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            child: LinearProgressIndicator(
              value: nilai / 255,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
