import 'package:flutter/material.dart';
// Import semua halaman Anda
import 'package:Barber/pages/booking.dart';
import 'package:Barber/pages/edit_profile.dart';
import 'package:Barber/pages/login.dart';
import 'package:Barber/pages/payment.dart';
import 'package:Barber/pages/profile.dart';
import 'package:Barber/pages/splash_screen.dart'; // Pastikan splash_screen diimpor
import 'package:Barber/pages/success.dart';
import 'package:Barber/pages/booking.detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      // --- PERUBAHAN DI SINI ---
      // Kita ubah 'home' dari ProfilePage() menjadi SplashScreen()
      // Ini akan membuat SplashScreen menjadi halaman pertama yang dimuat
      // saat aplikasi dimulai.
      home: const SplashScreen(),
      // --------------------------
    );
  }
}