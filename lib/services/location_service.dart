// MODUL VII - Location Based Services (geolocator)
import 'package:geolocator/geolocator.dart';
import 'package:poketrek/models/lokasi.dart';

class LocationService {
  static Future<Position> getCurrentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('GPS belum aktif, nyalakan dulu ya');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Izin lokasi ditolak');
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Jarak dalam meter dari posisi user ke sebuah lokasi
  static double hitungJarak(Position posisi, Lokasi lokasi) {
    return Geolocator.distanceBetween(
      posisi.latitude,
      posisi.longitude,
      lokasi.latitude,
      lokasi.longitude,
    );
  }
}
