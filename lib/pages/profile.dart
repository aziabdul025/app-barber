import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  bool _isNotificationOn = true;

  // ==========================================================
  // == PERUBAHAN WARNA AGAR SESUAI TEMA ==
  // ==========================================================
  // Mengganti 'darkPurple' dengan 'primaryPurple' yang lebih cerah
  final Color primaryPurple =
      const Color.fromARGB(255, 94, 53, 177); // (R:94, G:53, B:177)
  final Color lightGray = const Color(0xFFF5F5F5); // Latar belakang abu-abu
  final Color cardWhite = Colors.white;
  // Warna baru untuk navbar (dari gambar booking)
  final Color inactiveNavColor = const Color(0xFFB3A5D4);
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    // Dapatkan tinggi layar
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: lightGray, // Latar belakang utama

      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(), // <-- WIDGET INI DIUBAH TOTAL

      // Kita gunakan Stack untuk menumpuk header dan konten
      body: Stack(
        children: [
          // === LAYER 1: Header Ungu ===
          Container(
            height: screenHeight * 0.38,
            decoration: BoxDecoration(
              color: primaryPurple, // <-- PERUBAHAN: Warna diubah
              
              // ===============================================
              // == PATTERN BACKGROUND (SUDAH SAYA AKTIFKAN) ==
              // ===============================================
              image: const DecorationImage(
                // <-- PERUBAHAN: Path gambar dikembalikan sesuai permintaan Anda
                image: AssetImage('assets/images/group.png'),
                fit: BoxFit.cover,
                // <-- PERUBAHAN: Opacity 8 tidak valid, diubah ke 0.8
                opacity: 0.8, 
              ),
              // ===============================================

              // <-- PERUBAHAN: BorderRadius dihapus agar header lurus
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(40.0),
              //   bottomRight: Radius.circular(40.0),
              // ),
            ),
          ),

          // === LAYER 2: Info Profil (Avatar, Teks, dll.) ===
          _buildProfileInfo(), // <-- Ada perubahan di dalam widget ini

          // === LAYER 3: Konten Setting (Kartu Putih & Tombol) ===
          // <-- PERUBAHAN BESAR PADA STRUKTUR LAYOUT DI BAWAH INI -->
          Padding(
            padding: EdgeInsets.only(top: (screenHeight * 0.38) - 60),
            // 1. Ganti SingleChildScrollView menjadi Column
            child: Column(
              children: [
                // 2. Tambahkan Expanded agar kartu putih memenuhi sisa ruang
                Expanded(
                  child: Container(
                    // 3. Pindahkan styling dari _buildSettingsCard ke sini
                    width: double.infinity, // Memastikan lebar penuh
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
                    // 4. Buat Column internal untuk mengatur konten
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
                        const SizedBox(height: 16),
                
                        // Opsi "Security"
                        _buildSettingRow(
                          title: 'Security',
                          trailingWidget: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400, width: 1.5),
                            ),
                            child: Icon(Icons.edit, size: 18, color: Colors.grey[700]),
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
                            activeColor: primaryPurple,
                          ),
                          onTap: null, // Biar tidak ada efek klik
                        ),
                
                        // 5. Gunakan Spacer untuk mendorong tombol ke bawah
                        const Spacer(), 
                
                        // 6. Panggil tombol Logout di sini
                        _buildLogoutButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // <-- AKHIR DARI PERUBAHAN BESAR -->
        ],
      ),
    );
  }

  // --- WIDGET HELPER DI BAWAH INI ---

  /// WIDGET UNTUK INFO PROFIL (LAYER 2)
  Widget _buildProfileInfo() {
    return SafeArea(
      bottom: false, // Nonaktifkan SafeArea di bawah
      child: Padding(
        // <-- PERUBAHAN: Padding atas disesuaikan agar sedikit turun
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
                  // <-- PERUBAHAN: Path dan Ukuran dikembalikan sesuai permintaan Anda
                  icon: Image.asset(
                    'assets/images/gobar_icon.png', // Sesuai kode Anda
                    width: 80, // Sesuai kode Anda
                  ),
                ),
              ],
            ),
            
            // <-- PERUBAHAN: Jarak ditambah agar info user turun
            const SizedBox(height: 50),

            // Baris Info User (Foto, Nama, Email, Edit)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                // <-- PERUBAHAN: Menambahkan BORDER PUTIH di avatar
                CircleAvatar(
                  radius: 37, // Radius luar (border)
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35, // Radius dalam (gambar)
                    // <-- PERUBAHAN: Path dikembalikan sesuai permintaan Anda
                    backgroundImage: const AssetImage('assets/images/profile_pattern.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
                // =================================================
                
                const SizedBox(width: 16),

                // Kolom Nama & Email
                Column(
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
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
                        Text(
                          'Joesamanta@gmail.com',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(), // Mendorong ikon ke kanan
                // Tombol Edit
                IconButton(
                  onPressed: () {},
                  // <-- PERUBAHAN: Ikon dikembalikan ke 'edit' sesuai kode Anda
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // <-- PERUBAHAN: Widget _buildSettingsCard() dihapus karena logikanya dipindah
  /*
  /// WIDGET UNTUK KARTU SETTING (LAYER 3, BAGIAN 1)
  Widget _buildSettingsCard() {
    ...
  }
  */

  /// WIDGET UNTUK TOMBOL LOGOUT (LAYER 3, BAGIAN 2)
  Widget _buildLogoutButton() {
    // <-- PERUBAHAN: Padding dihapus karena sudah di-handle oleh padding kartu
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple, // <-- PERUBAHAN: Warna diubah
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

  // ==========================================================
  // == PERUBAHAN TOTAL PADA WIDGET INI ==
  // ==========================================================
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
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: primaryPurple, // Teks & Ikon Aktif Ungu
          unselectedItemColor: inactiveNavColor, // Teks & Ikon Non-Aktif
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              // Disarankan tambahkan navigasi di sini
              // if (index == 0) Navigator.pushReplacementNamed(context, '/home');
              // if (index == 1) Navigator.pushReplacementNamed(context, '/booking');
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          elevation: 0,
        ),
      ),
    );
  }
}

