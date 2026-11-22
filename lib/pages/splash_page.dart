// Cek session (Modul VI) lalu pushReplacement (Modul IV)
import 'package:flutter/material.dart';
import 'package:poketrek/pages/login_page.dart';
import 'package:poketrek/pages/root_page.dart';
import 'package:poketrek/services/session_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _cekSesi();
  }

  Future<void> _cekSesi() async {
    await Future.delayed(const Duration(seconds: 1));
    final username = await SessionService.getUsername();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            username == null ? const LoginPage() : RootPage(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.catching_pokemon, size: 96, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'PokéTrek',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
