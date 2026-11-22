// MODUL IV - BottomNavigationBar + MODUL VIII - badge reaktif (Obx)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poketrek/controllers/koleksi_controller.dart';
import 'package:poketrek/pages/jelajah_page.dart';
import 'package:poketrek/pages/koleksi_page.dart';
import 'package:poketrek/pages/pokedex_page.dart';
import 'package:poketrek/pages/profil_page.dart';

class RootPage extends StatefulWidget {
  final String username; // Modul IV - passing data lewat constructor

  const RootPage({super.key, required this.username});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages = [
    const PokedexPage(),
    const JelajahPage(),
    const KoleksiPage(),
    ProfilPage(username: widget.username),
  ];

  @override
  Widget build(BuildContext context) {
    final koleksiC = Get.find<KoleksiController>();

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Pokédex'),
          const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Jelajah'),
          BottomNavigationBarItem(
            icon: Obx(
              () => Badge(
                isLabelVisible: koleksiC.jumlah > 0,
                label: Text('${koleksiC.jumlah}'),
                child: const Icon(Icons.backpack),
              ),
            ),
            label: 'Koleksi',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
