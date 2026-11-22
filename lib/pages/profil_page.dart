// MODUL VI (SharedPreferences: mode demo & logout) + MODUL IV (pushAndRemoveUntil)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poketrek/controllers/koleksi_controller.dart';
import 'package:poketrek/pages/login_page.dart';
import 'package:poketrek/services/session_service.dart';

class ProfilPage extends StatefulWidget {
  final String username;

  const ProfilPage({super.key, required this.username});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _demoMode = false;

  @override
  void initState() {
    super.initState();
    SessionService.isDemoMode().then((value) {
      if (mounted) setState(() => _demoMode = value);
    });
  }

  Future<void> _logout() async {
    await SessionService.logout();
    if (!mounted) return;
    // Hapus semua halaman dari stack, kembali ke Login
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final koleksiC = Get.find<KoleksiController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 48, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 12),
          Text(
            'Trainer ${widget.username}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.backpack),
              title: const Text('Total Pokémon ditangkap'),
              trailing: Obx(
                () => Text(
                  '${koleksiC.jumlah}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.science),
              title: const Text('Mode Demo'),
              subtitle: const Text('Radius tangkap jadi 5 km (untuk presentasi)'),
              value: _demoMode,
              onChanged: (value) async {
                await SessionService.setDemoMode(value);
                setState(() => _demoMode = value);
              },
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
