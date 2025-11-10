import 'package:flutter/material.dart';
// 1. IMPORT DITAMBAHKAN UNTUK NAVIGASI
import 'package:Barber/pages/home.dart';
import 'package:Barber/pages/booking.dart';
import 'package:Barber/pages/edit_profile.dart'; // <-- IMPORT BARU DITAMBAHKAN
import 'package:Barber/pages/login.dart'; // <-- IMPORT BARU UNTUK LOGOUT

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2; // 2 karena ini Halaman Profil
  bool _isNotificationOn = true;

  // ==========================================================
  // == WARNA ==
  // ==========================================================
  final Color darkPurple = Color(0xFF2C1E4A);
  final Color lightGray = const Color(0xFFF5F5F5); // Latar belakang abu-abu
  final Color cardWhite = Colors.white;
  final Color inactiveNavColor = const Color(0xFFB3A5D4);
  // ==========================================================

  // 2. FUNGSI NAVIGASI DITAMBAHKAN
  void _onItemTapped(int index) {
    // Cek jika pengguna mengetuk tab yang sudah aktif, jangan lakukan apa-apa
    if (index == _selectedIndex) return;

    // Logika Navigasi
    switch (index) {
      case 0:
        // Pindah ke Halaman Home
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 1:
        // Pindah ke Halaman Booking
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const BookingPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      case 2:
        // Kita sudah di Profile, tidak perlu navigasi
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan tinggi layar
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: lightGray, // Latar belakang utama

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(),

      // Kita gunakan Stack untuk menumpuk header dan konten
      body: Stack(
        children: [
          // === LAYER 1: Header Ungu ===
          Container(
            height: screenHeight * 0.38,
            decoration: BoxDecoration(
              color: darkPurple,
              image: const DecorationImage(
                image: AssetImage('assets/images/group.png'),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
          ),

          // === LAYER 2: Info Profil (Avatar, Teks, dll.) ===
          _buildProfileInfo(),

          // === LAYER 3: Konten Setting (Kartu Putih & Tombol) ===
          Padding(
            padding: EdgeInsets.only(top: (screenHeight * 0.38) - 60),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: cardWhite,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul "Setting"
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Opsi "Security"
                        _buildSettingRow(
                          title: 'Security',
                          trailingWidget: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 1.5),
                            ),
                            child: Icon(Icons.edit,
                                size: 18, color: Colors.grey[700]),
                          ),
                          onTap: () {},
                        ),

                        // Opsi "Notification"
                        _buildSettingRow(
                          title: 'Notification',
                          trailingWidget: Switch(
                            value: _isNotificationOn,
                            onChanged: (value) {
                              setState(() {
                                _isNotificationOn = value;
                              });
                            },
                            activeColor: darkPurple,
                          ),
                          onTap: null, // Biar tidak ada efek klik
                        ),

                        const Spacer(), // Mendorong tombol ke bawah

                        // Tombol Logout
                        _buildLogoutButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER DI BAWAH INI ---

  /// WIDGET UNTUK INFO PROFIL (LAYER 2) - SUDAH DIPERBAIKI
  Widget _buildProfileInfo() {
    return SafeArea(
      bottom: false, // Nonaktifkan SafeArea di bawah
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0),
        child: Column(
          children: [
            // Baris "Profile" dan "Gobar"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/gobar_icon.png',
                    width: 80,
                  ),
                ),
              ],
            ),

            // =========================================================
            // === PERUBAHAN DI SINI ===
            // Jarak antara judul "Profile" dan baris Avatar dikurangi
            // dari 50 menjadi 30.
            const SizedBox(height: 30), // <-- DIUBAH DARI 50
            // =========================================================

            // Baris Info User (Foto, Nama, Email, Edit)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar dengan border putih
                CircleAvatar(
                  radius: 37, // Radius luar (border)
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35, // Radius dalam (gambar)
                    backgroundImage:
                        const AssetImage('assets/images/profile_pattern.png'),
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(width: 16),

                // === PERBAIKAN 1: BUNGKUS COLUMN DENGAN EXPANDED ===
                // Ini membuat Column mengambil sisa ruang di antara
                // Avatar dan Tombol Edit.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Jannah',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Badge Platinum
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Platinum',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 8),

                          // === PERBAIKAN 2: BUNGKUS TEXT DENGAN EXPANDED ===
                          // Ini membuat teks email terpotong (...)
                          // jika terlalu panjang.
                          Expanded(
                            child: Text(
                              'Joesamanta@gmail.com',
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // === PERBAIKAN 3: HAPUS SPACER ===
                // const Spacer(), // Tidak lagi diperlukan karena Column sudah di-Expanded

                // Tombol Edit
                IconButton(
                  onPressed: () {
                    // === NAVIGASI KE EDIT PROFILE DITAMBAHKAN ===
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                    // ==========================================
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// WIDGET UNTUK TOMBOL LOGOUT
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // === NAVIGASI KE LOGIN PAGE DITAMBAHKAN ===
          // Kita gunakan pushReplacement agar pengguna tidak bisa kembali
          // ke halaman profile setelah logout.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
          // =======================================
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Text(
          'Log out',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// WIDGET HELPER UNTUK BARIS SETTING
  Widget _buildSettingRow({
    required String title,
    required Widget trailingWidget,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black, // Warna teks di dalam kartu
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            trailingWidget,
          ],
        ),
      ),
    );
  }

  /// WIDGET HELPER UNTUK BOTTOM NAV BAR (Sesuai tema)
  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 80.0,
        color: cardWhite, // Background Bottom Nav Putih
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            // --- ITEM HOME ---
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), // Ikon sesuai gambar
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            // --- ITEM BOOKING ---
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Booking',
            ),
            // --- ITEM PROFILE ---
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex, // 2 (Profil)
          backgroundColor: Colors.transparent,
          selectedItemColor: darkPurple, // Teks & Ikon Aktif Ungu
          unselectedItemColor: inactiveNavColor, // Teks & Ikon Non-Aktif

          // 3. ONTAP DIPERBARUI UNTUK NAVIGASI
          onTap: _onItemTapped,

          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          elevation: 0,
        ),
      ),
    );
  }
}