import 'package:flutter/material.dart';
// 1. TAMBAHKAN baris ini untuk "mengenalkan" file login.dart
import 'package:flutter_application_1/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo', // (Ini boleh dihapus)
      debugShowCheckedModeBanner: false, // (Lebih rapi tanpa banner debug)

      // 2. UBAH TEMA
      // Kita ganti tema bawaan (terang) menjadi tema gelap
      // agar cocok dengan desain halaman login kita.
      theme: ThemeData.dark(),

      // 3. UBAH 'home'
      // Ganti 'const MyHomePage(title: 'Flutter Demo Home Page')'
      // dengan 'const LoginPage()'
      home: const LoginPage(),
    );
  }
}

// 4. HAPUS SEMUA SISA KODE
//
// Seluruh class 'MyHomePage' dan '_MyHomePageState'
// yang ada di bawah baris ini di file lama Anda
// BISA DIHAPUS SEMUA, karena sudah tidak kita panggil lagi.
//
// class MyHomePage extends StatefulWidget { ... }
// class _MyHomePageState extends State<MyHomePage> { ... }
