// MODUL VII - LBS (lokasi terdekat) + Notifikasi (immediate & scheduled)
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:poketrek/controllers/koleksi_controller.dart';
import 'package:poketrek/data/daftar_lokasi.dart';
import 'package:poketrek/models/caught_pokemon.dart';
import 'package:poketrek/models/lokasi.dart';
import 'package:poketrek/services/api_service.dart';
import 'package:poketrek/services/location_service.dart';
import 'package:poketrek/services/notification_service.dart';
import 'package:poketrek/services/session_service.dart';
import 'package:poketrek/utils/format.dart';

class JelajahPage extends StatefulWidget {
  const JelajahPage({super.key});

  @override
  State<JelajahPage> createState() => _JelajahPageState();
}

class _JelajahPageState extends State<JelajahPage> {
  static const double radiusNormal = 100; // meter
  static const double radiusDemo = 5000; // meter (Mode Demo di Profil)

  Position? _posisi;
  bool _isLoading = false;
  bool _demoMode = false;
  String? _error;
  List<Map<String, dynamic>> _lokasiDenganJarak = [];

  double get _radius => _demoMode ? radiusDemo : radiusNormal;

  Future<void> _cekLokasi() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final posisi = await LocationService.getCurrentPosition();
      final demo = await SessionService.isDemoMode();

      final hasil = daftarLokasi
          .map((l) => {'lokasi': l, 'jarak': LocationService.hitungJarak(posisi, l)})
          .toList()
        ..sort((a, b) => (a['jarak'] as double).compareTo(b['jarak'] as double));

      if (!mounted) return;
      setState(() {
        _posisi = posisi;
        _demoMode = demo;
        _lokasiDenganJarak = hasil;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _tangkap(SpawnSpot spot) async {
    try {
      final detail = await ApiService.getPokemonDetail(spot.pokemonId);
      await Get.find<KoleksiController>().tangkap(
        CaughtPokemon(
          pokemonId: detail.id,
          name: detail.displayName,
          nickname: detail.displayName,
          imageUrl: detail.imageUrl,
          spotName: spot.nama,
          caughtAt: DateTime.now(),
        ),
      );
      // Immediate notification
      await NotificationService().showInstantNotification(
        title: 'Gotcha! ${detail.displayName} tertangkap 🎉',
        body: 'Ditangkap di ${spot.nama}. Cek di Tas Koleksi ya!',
      );
    } catch (e) {
      Get.snackbar('Gagal menangkap', e.toString());
    }
  }

  Future<void> _setReminder(Lokasi lokasi) async {
    final now = DateTime.now();
    final tanggal = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (tanggal == null || !mounted) return;

    final jam = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(minutes: 1))),
    );
    if (jam == null) return;

    final waktu = DateTime(tanggal.year, tanggal.month, tanggal.day, jam.hour, jam.minute);
    if (waktu.isBefore(DateTime.now())) {
      Get.snackbar('Waktu tidak valid', 'Pilih waktu yang belum lewat');
      return;
    }

    // Scheduled notification
    await NotificationService().scheduleNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: 'Waktunya berburu! ⏰',
      body: 'Jangan lupa ke ${lokasi.nama}. ${lokasi.deskripsi()}',
      scheduledTime: waktu,
    );
    Get.snackbar('Reminder dipasang', 'Kamu akan diingatkan pada ${formatTanggal(waktu)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jelajah')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      _posisi == null
                          ? 'Lokasimu belum diketahui'
                          : 'Posisimu: ${_posisi!.latitude.toStringAsFixed(5)}, ${_posisi!.longitude.toStringAsFixed(5)}',
                    ),
                    Text(
                      'Radius tangkap: ${formatJarak(_radius)}${_demoMode ? ' (Mode Demo)' : ''}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    if (_error != null)
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _isLoading ? null : _cekLokasi,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.my_location),
                      label: const Text('Cek Lokasi Saya'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _lokasiDenganJarak.length,
              itemBuilder: (context, index) {
                final lokasi = _lokasiDenganJarak[index]['lokasi'] as Lokasi;
                final jarak = _lokasiDenganJarak[index]['jarak'] as double;
                return _kartuLokasi(lokasi, jarak);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _kartuLokasi(Lokasi lokasi, double jarak) {
    final dalamRadius = jarak <= _radius;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                if (lokasi is SpawnSpot)
                  // Siluet hitam kalau masih jauh, berwarna kalau sudah dekat
                  Image.network(
                    lokasi.spriteUrl,
                    width: 64,
                    height: 64,
                    color: dalamRadius ? null : Colors.black,
                  )
                else
                  const SizedBox(
                    width: 64,
                    height: 64,
                    child: Icon(Icons.local_hospital, color: Colors.pink, size: 40),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lokasi.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(lokasi.deskripsi()), // polymorphism
                      Text(
                        formatJarak(jarak),
                        style: TextStyle(color: dalamRadius ? Colors.green : Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _setReminder(lokasi),
                  icon: const Icon(Icons.alarm),
                  label: const Text('Ingatkan'),
                ),
                if (lokasi.bisaDitangkap)
                  FilledButton.icon(
                    onPressed: dalamRadius ? () => _tangkap(lokasi as SpawnSpot) : null,
                    icon: const Icon(Icons.catching_pokemon),
                    label: Text(dalamRadius ? 'Tangkap!' : 'Terlalu jauh'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
