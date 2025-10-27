import 'package:flutter/material.dart';

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
            // Aksi untuk tombol close, misalnya kembali ke halaman sebelumnya
            // Navigator.pop(context);
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
                  // Aksi saat "Cash" diklik
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
                  // Aksi saat "Qris" diklik
                },
              ),
            ],
          ),
        ),
      ),

      // ================== PERUBAHAN DI SINI ==================
      // 4. Bottom Navigation Bar dengan Tinggi Kustom
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        // 1. Bungkus dengan Container
        child: Container(
          height: 80.0, // 2. Atur tinggi di sini (misal: 80)
          color: Colors.white, // 3. Pindahkan warna ke Container
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home), // Ikon saat aktif
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                activeIcon: Icon(Icons.calendar_today),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            // 4. Atur warna Nav Bar jadi transparan agar warna Container terlihat
            backgroundColor: Colors.transparent, 
            selectedItemColor: Colors.grey[800], 
            unselectedItemColor: Colors.grey[400], 
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed, 
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            elevation: 0, // 5. Pastikan elevation 0
          ),
        ),
      ),
      // =======================================================
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