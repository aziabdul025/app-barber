import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // State untuk Bottom Nav Bar (Profile = index 2)
  int _selectedIndex = 2;
  // State untuk Switch Notifikasi
  bool _isNotificationOn = true;

  // Definisikan warna-warna
  final Color darkPurple = const Color(0xFF2C1E4A);
  final Color lightGray = const Color(0xFFF5F5F5); // Latar belakang abu-abu
  final Color cardWhite = Colors.white;

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
            // Tingginya 38% dari layar (bisa diubah)
            height: screenHeight * 0.38,
            decoration: BoxDecoration(
              color: darkPurple,
              // ===============================================
              // GANTI KOMENTAR INI DENGAN GAMBAR PATTERN ANDA
              // image: DecorationImage(
              //   // PASTIKAN ANDA PUNYA GAMBAR INI DI:
              //   // assets/images/profile_pattern.png
              //   // DAN SUDAH DIDAFTARKAN DI pubspec.yaml
              //   image: AssetImage('assets/images/profile_pattern.png'),
              //   fit: BoxFit.cover,
              //   opacity: 0.1, // Dibuat redup
              // ),
              // ===============================================
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
          ),

          // === LAYER 2: Info Profil (Avatar, Teks, dll.) ===
          // Ini adalah konten yang ada DI DALAM header ungu
          _buildProfileInfo(),

          // === LAYER 3: Konten Setting (Kartu Putih & Tombol) ===
          Padding(
            // Posisi 'top' ini adalah kuncinya.
            // (Tinggi Header * 0.38) - 60px overlap
            padding: EdgeInsets.only(top: (screenHeight * 0.38) - 60),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Ini adalah Kartu "Setting" yang putih
                  _buildSettingsCard(),

                  // Ini adalah tombol "Log out"
                  _buildLogoutButton(),

                  // Beri jarak di bawah
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
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
        // ================== PERUBAHAN 1 ==================
        // Padding atas ditambah agar 'Profile' & 'Gobar' turun
        padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0),
        // =================================================

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
                // KODE BARU (HANYA ICON)
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/gobar_icon.png',
                    // ================== PERUBAHAN 2 ==================
                    // Width 80 terlalu besar dan tidak sesuai gambar.
                    // Disesuaikan agar lebih pas.
                    width: 40,
                    // =================================================
                  ),
                ),
              ],
            ),
            
            // ================== PERUBAHAN 3 ==================
            // Beri jarak lebih agar avatar turun
            const SizedBox(height: 35), // <-- Diubah dari 30
            // =================================================

            // Baris Info User (Foto, Nama, Email, Edit)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                // ================== PERUBAHAN 4 ==================
                // Mengembalikan ke placeholder icon agar tidak error
                // dan sesuai gambar referensi awal.
                // Ganti 'backgroundImage' dengan path gambar Anda.
                const CircleAvatar(
                  radius: 35,
                  // backgroundImage: AssetImage('assets/images/foto_profil_anda.png'),
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.grey),
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
                  // Ganti ikonnya agar lebih mirip (pensil)
                  icon: const Icon(Icons.edit, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// WIDGET UNTUK KARTU SETTING (LAYER 3, BAGIAN 1)
  Widget _buildSettingsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(30.0), // Sudut melengkung
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
              activeColor: darkPurple, // Warna saat aktif
            ),
            onTap: null, // Biar tidak ada efek klik
          ),
        ],
      ),
    );
  }

  /// WIDGET UNTUK TOMBOL LOGOUT (LAYER 3, BAGIAN 2)
  Widget _buildLogoutButton() {
    return Padding(
      // Beri jarak dari kartu setting
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 40.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPurple, // Warna tombol
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

  /// WIDGET HELPER UNTUK BOTTOM NAV BAR
  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 80.0,
        color: Colors.white,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
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
          elevation: 0,
        ),
      ),
    );
  }
}