// lib/pages/splash_page.dart

import 'package:flutter/material.dart';
import 'package:todo_app_supabase/main.dart'; // Impor main.dart untuk akses supabase
import 'package:todo_app_supabase/pages/home_page.dart';
import 'package:todo_app_supabase/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect(); // Panggil fungsi redirect saat halaman pertama kali dimuat
  }

  Future<void> _redirect() async {
    // Tunggu sebentar untuk memberi efek splash screen
    await Future.delayed(Duration.zero);

    // Cek apakah ada sesi login yang aktif
    final session = supabase.auth.currentSession;

    if (!mounted) return; // Pastikan widget masih ada di tree

    if (session != null) {
      // Jika ada sesi, arahkan ke HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Jika tidak ada sesi, arahkan ke LoginPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Tampilkan loading indicator
      ),
    );
  }
}