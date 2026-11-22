# PokéTrek

Project akhir Praktikum Pemrograman Aplikasi Mobile. Tangkap Pokémon di sekitar kampus!

## Cara menjalankan
```
flutter pub get
flutter run
```
Akun login: `admin` / `admin123` atau `trainer` / `pokemon`

## Peta modul -> file
| Modul | File |
|---|---|
| I - OOP | `models/lokasi.dart`, `models/pokemon.dart` |
| II - Widget | `widgets/`, `pages/pokedex_page.dart` (GridView), `pages/detail_page.dart` |
| III - State & Data | `pages/login_page.dart`, `models/user.dart`, `widgets/custom_text_field.dart` |
| IV - Navigation | `pages/root_page.dart` (BottomNav), push/pop/pushReplacement/pushAndRemoveUntil |
| V - HTTP Request | `services/api_service.dart`, `pages/detail_page.dart` (FutureBuilder) |
| VI - Local Storage | `services/session_service.dart` (SharedPreferences), `models/caught_pokemon.dart` + `controllers/koleksi_controller.dart` (Hive CRUD) |
| VII - Notif & LBS | `services/notification_service.dart`, `services/location_service.dart`, `pages/jelajah_page.dart` |
| VIII - GetX | `controllers/`, `Obx` di root/pokedex/koleksi/profil |

## Tips demo
- Ganti koordinat di `lib/data/daftar_lokasi.dart` dengan titik asli kampus.
- Emulator: Extended Controls (⋯) -> Location -> geser titik ke dekat spot.
- Kalau GPS rewel: Profil -> nyalakan **Mode Demo** (radius 5 km).
