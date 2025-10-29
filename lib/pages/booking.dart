import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectedIndex = 1;
  int _selectedTabIndex = 0;

  // ==========================================================
  // == PASTIKAN WARNA INI SESUAI DENGAN GAMBAR ANDA ==
  // ==========================================================

  // <-- PERBAIKAN DI SINI: Menambahkan primaryPurple dengan format ARGB
  final Color primaryPurple =
      const Color.fromARGB(255, 94, 53, 177); // Ini adalah (R:94, G:53, B:177)

  final Color lightPurple =
      const Color(0xFFEDE7F6); // Ungu muda untuk background Tab
  final Color white = Colors.white;
  // <-- PERBAIKAN DI SINI: Mengembalikan ke abu-abu yang lebih sesuai
  final Color greyText = Colors.grey.shade600;
  final Color darkText = Colors.black87;
  // ==========================================================

  // ==========================================================
  // == PASTIKAN PATH GAMBAR INI BENAR-BENAR ADA DI PROYEK ANDA ==
  // ==========================================================
  final List<Map<String, String>> services = [
    {
      'image': 'assets/images/photo.png',
      'name': 'Basic haircut',
      'detail': 'Basic haircut & vitamint'
    },
    {
      'image': 'assets/images/photo1.png',
      'name': 'Massage',
      'detail': 'Extra massage'
    },
    {
      'image': 'assets/images/photo2.png',
      'name': 'Hair Coloring',
      'detail': 'Extra massage'
    },
    {
      'image': 'assets/images/photo3.png',
      'name': 'Kids haircut',
      'detail': 'Extra massage'
    },
  ];
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          white, // <-- PERBAIKAN DI SINI: Background harusnya putih, bukan transparan
      appBar: AppBar(
        backgroundColor: primaryPurple, // AppBar Ungu
        foregroundColor: white, // Teks & Ikon AppBar Putih
        title: const Text('Booking'),
        actions: [
          IconButton(
            onPressed: () {},
            // ==========================================================
            // == PASTIKAN FILE INI ADA DI assets/images/ ==
            // ==========================================================
            icon: Image.asset(
              // <-- PERBAIKAN DI SINI: Gunakan ikon versi putih agar terlihat di AppBar ungu
              'assets/images/gobar_icon.png',
              width: 80,
            ),
            // ==========================================================
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildActiveBookingContent()
                : _buildHistoryContent(),
          ),
        ],
      ),
    );
  }

  /// WIDGET UNTUK TAB BAR
  Widget _buildTabBar() {
    return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: lightPurple, // Background Tab Ungu Muda
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            _buildTabItem(index: 0, text: 'Active booking'),
            _buildTabItem(index: 1, text: 'History'),
          ],
        ),
      ),
    );
  }

  /// WIDGET HELPER UNTUK ITEM TAB (DENGAN SHADOW)
  Widget _buildTabItem({required int index, required String text}) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? white : Colors.transparent, // Tab aktif Putih
            borderRadius: BorderRadius.circular(25.0),
            // Ini adalah bagian penting untuk efek "pop-up"
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      // <-- PERBAIKAN DI SINI: Shadow harusnya abu-abu, bukan putih
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? darkText : greyText, // Teks aktif Hitam
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// WIDGET UNTUK KONTEN BOOKING AKTIF
  Widget _buildActiveBookingContent() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        _buildSectionHeader(
            icon: Icons.calendar_today_outlined, title: 'Date & time'),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Text(
            'Sun, 15 Jan - 08:00 AM',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
          ),
        ),
        const SizedBox(height: 30),
        _buildSectionHeader(
            icon: Icons.cut_outlined, title: 'Service selected'),
        const SizedBox(height: 15),
        Column(
          children: services
              .map((service) => _buildServiceItem(
                    imagePath:
                        service['image']!, // Menggunakan path gambar dari list
                    title: service['name']!,
                    subtitle: service['detail']!,
                  ))
              .toList(),
        ),
      ],
    );
  }

  /// WIDGET HELPER UNTUK HEADER SECTION
  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: greyText, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
              fontSize: 16, color: greyText, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  /// WIDGET HELPER UNTUK ITEM LAYANAN (MENGGUNAKAN GAMBAR ASLI)
  Widget _buildServiceItem(
      {required String imagePath,
      required String title,
      required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          // ==========================================================
          // == Ini akan memuat gambar dari path yang Anda definisikan ==
          // ==========================================================
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(imagePath), // <-- Ini memuat gambar
            backgroundColor:
                Colors.grey[200], // Background jika gambar gagal dimuat
          ),
          // ==========================================================
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: greyText),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// WIDGET UNTUK KONTEN HISTORY
  Widget _buildHistoryContent() {
    return const Center(
      child: Text(
        'Booking History Content Here',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  /// WIDGET HELPER UNTUK BOTTOM NAV BAR
 /// WIDGET HELPER UNTUK BOTTOM NAV BAR
  Widget _buildBottomNav() {
    // Kita bungkus semua dengan Column
    return Column(
      mainAxisSize: MainAxisSize.min, // PENTING: Agar Column tidak memenuhi layar
      children: [
        
        // 1. INI ADALAH GARIS LURUSNYA
        Container(
          height: 1.0, // Ketebalan garis
          color: Colors.grey[300], // Warna garis, bisa disesuaikan
        ),

        // 2. Ini adalah kode navbar Anda yang sudah ada
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: Container(
            height: 80.0,
            color: white, // Background Bottom Nav Putih
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: greyText),
                  activeIcon:
                      Icon(Icons.home, color: primaryPurple), // Ikon Aktif Ungu
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined, color: greyText),
                  activeIcon: Icon(Icons.calendar_today, color: primaryPurple),
                  label: 'Booking',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, color: greyText),
                  activeIcon: Icon(Icons.person, color: primaryPurple),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              backgroundColor: Colors.transparent,
              selectedItemColor: primaryPurple, // Teks Aktif Ungu
              unselectedItemColor: greyText,
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
        ),
      ],
    );
  }
}
