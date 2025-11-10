import 'package:flutter/material.dart';
// === 1. TAMBAHKAN IMPORT UNTUK SUCCESS PAGE ===
// (Pastikan path dan nama file/class sudah benar)
import 'package:Barber/pages/success.dart'; // Ganti jika namanya beda
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // State untuk melacak item mana yang aktif di bottom nav bar
  int _selectedIndex = 1; // 0=Home, 1=Booking, 2=Profile
  // Warna ungu tua dari desain
  final Color darkPurple = const Color(0xFF2C1E4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPurple,
      // 1. App Bar Kustom
      appBar: AppBar(
        // Kita buat warnanya sama dengan body dan tanpa bayangan
        backgroundColor: darkPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            // === 2. AKSI TOMBOL CLOSE (KEMBALI KE HALAMAN SEBELUMNYA) ===
            // Ini akan kembali ke halaman dari mana Anda datang (misalnya BookingPage)
            Navigator.pop(context);
          },
        ),
      ),
      // 2. Body Halaman
      body: SafeArea(
        child: Padding(
          // Beri padding horizontal di sisi kiri dan kanan
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // Ratakan semua elemen ke kiri
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Utama
              const Text(
                'Add new payment method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32), // Jarak
              // Judul Grup
              Text(
                'Bank Deposit',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 16), // Jarak
              // 3. Opsi Pembayaran (kita buat widget sendiri di bawah)
              // Opsi "Cash"
              _buildPaymentOption(
                // Menggunakan Image.asset dengan path yang benar
                iconWidget: Image.asset(
                  'assets/images/cash.png', // Pastikan path ini benar
                  width: 28,
                  height: 28,
                ),

                title: 'Cash',
                onTap: () {
                  // === 3. AKSI SAAT "CASH" DIKLIK (NAVIGASI KE SUCCESS) ===
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Pastikan Anda punya class bernama SuccessPage
                      builder: (context) => const SuccessPage(),
                    ),
                  );
                },
              ),

              // Opsi "Qris"
              _buildPaymentOption(
                iconWidget: const Icon(
                  Icons.qr_code_2_outlined,
                  color: Colors.white,
                  size: 28, // Sedikit lebih besar agar pas
                ),
                title: 'Qris',
                onTap: () {
                  // Aksi saat "Qris" diklik (bisa ditambahkan nanti)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget helper untuk membuat baris opsi pembayaran

  Widget _buildPaymentOption({
    required Widget iconWidget,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            // Ikon

            SizedBox(
              width: 30, // Beri lebar agar ikon rata
              child: iconWidget,
            ),

            const SizedBox(width: 16),

            // Teks
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            // Spacer untuk mendorong panah ke kanan

            const Spacer(),

            // Ikon Panah

            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
