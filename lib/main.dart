import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_supabase/pages/splash_page.dart';


Future<void> main() async {
  // Pastikan semua widget sudah siap sebelum menjalankan kode Supabase
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase dengan URL dan Anon Key Anda
  await Supabase.initialize(
    url: 'https://ktsqxbzjfcazpsapsqki.supabase.com', // URL Anda sudah benar
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0c3F4YnpqZmNhenBzYXBzcWtpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0NDc0MDIsImV4cCI6MjA2NjAyMzQwMn0.XBThv-YAbQydAO0yU8hrGTq3aqZ_dzi4BOky-_umqek', // Anon Key Anda sudah benar
  ); // <-- PASTIKAN ADA TANDA ')' DAN ';' DI SINI

  runApp(const MyApp()); // <-- PASTIKAN ADA TANDA ')' DAN ';' DI SINI
} // <-- PASTIKAN ADA TANDA '}' PENUTUP UNTUK FUNGSI main

// Helper untuk mempermudah pemanggilan client Supabase di seluruh aplikasi
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: const SplashPage(
        // Untuk sementara, kita buat halaman kosong dulu

      ), // <-- Pastikan ada koma di sini
    ); // <-- PASTIKAN ADA TANDA ')' DAN ';' DI SINI
  } // <-- PASTIKAN ADA TANDA '}' PENUTUP UNTUK FUNGSI build
} // <-- PASTIKAN ADA TANDA '}' PENUTUP UNTUK CLASS MyApp