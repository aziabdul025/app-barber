import 'package:Barber/pages/booking.detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Barber/pages/home.dart';
import 'package:Barber/pages/profile.dart';
// === 1. TAMBAHKAN IMPORT UNTUK PAYMENT PAGE ===
// (Pastikan path dan nama file/class sudah benar)
import 'package:Barber/pages/booking.detail.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectedIndex = 1; // 1 karena ini halaman Booking
  int _selectedTabIndex = 0;

  // ==========================================================
  // == WARNA ==
  // ==========================================================
  final Color darkPurple =  
  Color(0xFF2C1E4A);
  final Color lightPurple =
      const Color(0xFFEDE7F6); // Ungu muda untuk background Tab
  final Color white = Colors.white;
  final Color greyText = Colors.grey.shade600;
  final Color darkText = Colors.black87;

  // === PERUBAHAN 1: Tambahkan 2 variabel warna ini agar sama dengan Home/Profile ===
  final Color cardWhite = Colors.white;
  final Color inactiveNavColor = const Color(0xFFB3A5D4);
  // ==========================================================

  // ==========================================================
  // == DATA (PASTIKAN PATH GAMBAR BENAR) ==
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

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
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
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const ProfilePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkPurple,
        foregroundColor: white,
        title: const Text('Booking'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/gobar_icon.png',
              width: 80,
            ),
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(), // <-- Ini akan memanggil versi baru
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
          color: lightPurple,
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
            color: isSelected ? white : Colors.transparent,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
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
                color: isSelected ? darkText : greyText,
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
  // === 2. PERUBAHAN PADA FUNGSI INI ===
  Widget _buildServiceItem(
      {required String imagePath,
      required String title,
      required String subtitle}) {
    // Dibungkus dengan InkWell agar bisa di-klik dan ada efek ripple
    return InkWell(
      onTap: () {
        // === INI ADALAH LOGIKA NAVIGASI KE PAYMENT PAGE ===
        Navigator.push(
          context,
          MaterialPageRoute(
            // Pastikan Anda punya class bernama PaymentPage di payment.dart
            builder: (context) => const BookingDetailScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0), // Padding tetap di dalam
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(imagePath), // <-- Ini memuat gambar
              backgroundColor:
                  Colors.grey[200], // Background jika gambar gagal dimuat
            ),
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

  // === PERUBAHAN 2: GANTI SELURUH FUNGSI _buildBottomNav DI BAWAH INI ===
  /// WIDGET HELPER UNTUK BOTTOM NAV BAR (Sesuai tema Home/Profile)
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
          currentIndex: _selectedIndex, // Ini akan menggunakan state (1)
          backgroundColor: Colors.transparent,
          selectedItemColor: darkPurple, // Teks & Ikon Aktif Ungu
          unselectedItemColor: inactiveNavColor, // Teks & Ikon Non-Aktif
          onTap: _onItemTapped, // Panggil fungsi navigasi
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          elevation: 0,
        ),
      ),
    );
  }
}