// MODUL VI - Shared Preferences (session login + setting mode demo)
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyUsername = 'username';
  static const String _keyDemoMode = 'demo_mode';

  static Future<void> saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  /// null artinya belum login
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }

  /// Reaktif: Jelajah (Obx) otomatis ikut berubah saat Profil mengganti mode.
  static final RxBool demoMode = false.obs;

  static Future<bool> isDemoMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_keyDemoMode) ?? false;
    demoMode.value = value;
    return value;
  }

  static Future<void> setDemoMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDemoMode, value);
    demoMode.value = value;
  }
}
