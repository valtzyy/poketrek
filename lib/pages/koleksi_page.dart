// MODUL VI - Tampilan CRUD Hive (Read, Update, Delete) + MODUL VIII - Obx
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poketrek/controllers/koleksi_controller.dart';
import 'package:poketrek/models/caught_pokemon.dart';
import 'package:poketrek/pages/detail_page.dart';
import 'package:poketrek/utils/format.dart';

class KoleksiPage extends StatelessWidget {
  const KoleksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<KoleksiController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Tas Koleksi')),
      body: Obx(() {
        if (c.koleksi.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.backpack_outlined, size: 72, color: Colors.grey),
                SizedBox(height: 8),
                Text('Belum ada Pokémon. Yuk ke tab Jelajah!'),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: c.koleksi.length,
          itemBuilder: (context, index) {
            final p = c.koleksi[index];
            return Card(
              child: ListTile(
                leading: Image.network(p.imageUrl, width: 56),
                title: Text(p.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${p.name} • ${p.spotName}\n${formatTanggal(p.caughtAt)}'),
                isThreeLine: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(id: p.pokemonId, name: p.name),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'rename') {
                      _dialogGantiNama(context, c, index, p);
                    } else {
                      _dialogLepaskan(context, c, index, p);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'rename', child: Text('Ganti nickname')),
                    PopupMenuItem(value: 'lepas', child: Text('Lepaskan')),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _dialogGantiNama(BuildContext context, KoleksiController c, int index, CaughtPokemon p) {
    final controller = TextEditingController(text: p.nickname);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ganti nickname'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                c.gantiNickname(index, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _dialogLepaskan(BuildContext context, KoleksiController c, int index, CaughtPokemon p) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lepaskan Pokémon?'),
        content: Text('${p.nickname} akan dilepas ke alam liar.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              c.lepaskan(index);
              Navigator.pop(context);
            },
            child: const Text('Lepaskan'),
          ),
        ],
      ),
    );
  }
}
