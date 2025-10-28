import 'dart:async'; // Untuk Timer
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk SystemUiOverlayStyle
// Impor halaman tujuan Anda (misalnya halaman login)
import 'login.dart'; // Ganti 'login.dart' jika nama file login Anda berbeda

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Warna ungu tua
  final Color darkPurple = const Color(0xFF2C1E4A);

  @override
  void initState() {
    super.initState();
    // Atur timer untuk pindah halaman setelah beberapa detik
    Timer(const Duration(seconds: 3), () {
      // Pindah ke halaman Login (atau halaman utama Anda)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()), // Ganti LoginPage jika perlu
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Atur warna status bar (jam, baterai) agar kontras
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // Transparan agar menyatu
      statusBarIconBrightness: Brightness.light, // Ikon terang (putih)
    ));

    return Scaffold(
      backgroundColor: darkPurple, // Latar belakang ungu
      body: Center( // Pusatkan logo di tengah
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
          children: [
            // Logo Anda
            Image.asset(
              'assets/images/gobar_icon.png', // Pastikan path ini benar
              width: 250, // Atur ukuran logo sesuai keinginan
              // Anda bisa tambahkan height jika perlu
            ),
            // Anda bisa tambahkan teks di bawah logo jika mau
            // const SizedBox(height: 20),
            // const Text(
            //   'Gobar App',
            //   style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}