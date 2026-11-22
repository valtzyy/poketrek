// MODUL III - State & Data: form login, setState, error handling
import 'package:flutter/material.dart';
import 'package:poketrek/models/user.dart';
import 'package:poketrek/pages/root_page.dart';
import 'package:poketrek/services/session_service.dart';
import 'package:poketrek/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginFailed = false;

  Future<void> _login() async {
    final cocok = dummyUsers.where(
      (u) =>
          u.username == _usernameController.text &&
          u.password == _passwordController.text,
    );

    if (cocok.isEmpty) {
      setState(() => _isLoginFailed = true);
      return;
    }

    final username = cocok.first.username;
    await SessionService.saveLogin(username); // Modul VI
    if (!mounted) return;

    // Modul IV - pushReplacement: user tidak bisa "back" ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RootPage(username: username)),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              const Icon(Icons.catching_pokemon, size: 96, color: Colors.red),
              const SizedBox(height: 8),
              const Text(
                'PokéTrek',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Tangkap Pokémon di sekitar kampus!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.person,
                isError: _isLoginFailed,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
                isError: _isLoginFailed,
              ),
              if (_isLoginFailed) ...[
                const SizedBox(height: 8),
                const Text(
                  'Username atau password salah',
                  style: TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _login,
                style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
