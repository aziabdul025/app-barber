// ================== PERBAIKAN DI SINI ==================
import 'package:flutter/material.dart'; // <-- Pastikan pakai TITIK DUA (:)
// =======================================================

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  // Warna ungu tua dari desain
  final Color darkPurple = const Color(0xFF2C1E4A);
  // Warna ungu yang sedikit lebih terang
  final Color lightPurple = const Color(0xFF4A3482); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Latar belakang gradasi ungu
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkPurple, lightPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            // Biarkan rata kiri untuk tombol "Go back"
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // 2. App Bar Kustom
              Padding(
                // Tambahkan padding 'top' agar tombol sedikit turun
                padding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0),
                child: Row(
                  children: [
                    // Tombol "Go back"
                    TextButton.icon(
                      onPressed: () {
                        // Aksi untuk kembali, misalnya ke halaman utama
                        // Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                      label: const Text(
                        'Go back',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 3. Konten Utama (Icon dan Teks)
              // Kita ganti 'Center' dengan Column + Spacer
              Expanded(
                child: Column(
                  // Ratakan secara horizontal
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Spacer atas (lebih kecil)
                    const Spacer(flex: 2),

                    // --- Konten Utama ---
                    const Icon(
                      Icons.verified, 
                      color: Colors.white,
                      size: 120.0,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Booking Successfully',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Immediately check the booking menu for detailed information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // --- Akhir Konten Utama ---

                    // Spacer bawah (lebih besar, untuk mendorong konten ke atas)
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}