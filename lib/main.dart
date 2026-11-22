import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poketrek/controllers/koleksi_controller.dart';
import 'package:poketrek/controllers/pokedex_controller.dart';
import 'package:poketrek/models/caught_pokemon.dart';
import 'package:poketrek/pages/splash_page.dart';
import 'package:poketrek/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Modul VI - Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CaughtPokemonAdapter());
  await Hive.openBox<CaughtPokemon>('koleksi');

  // Modul VII - Notifikasi
  await NotificationService().init();

  // Modul VIII - Dependency Injection GetX
  Get.put(KoleksiController());
  Get.put(PokedexController());

  runApp(const PokeTrekApp());
}

class PokeTrekApp extends StatelessWidget {
  const PokeTrekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PokéTrek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      home: const SplashPage(),
    );
  }
}
