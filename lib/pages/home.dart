import 'package:flutter/material.dart';

// Impor ini saya ambil dari cuplikan kode Anda.
// Pastikan file-file ini ada dan berisi kelas 'BookingPage' dan 'ProfilePage'.
import 'package:Barber/pages/booking.dart';
import 'package:Barber/pages/profile.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <-- IMPOR INI SUDAH ADA

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- State & Warna ---
  int _selectedIndex = 0;
  final Color darkPurple =  
  Color(0xFF2C1E4A);
  final Color cardWhite = Colors.white;
  final Color inactiveNavColor = Colors.grey;

  // --- Warna BARU berdasarkan gambar desain ---
  final Color scaffoldBgColor =
      const Color(0xFFF9F9F9); // Latar belakang putih/abu muda
  final Color orangePromoColor =
      const Color.fromARGB(255, 255, 145, 27); // Warna oranye kartu promo
  final Color darkTextColor =
      const Color(0xFF1F2937); // Warna teks gelap agar mudah dibaca
  
  // Warna ungu tua untuk header dan tombol booking, disesuaikan dari gambar
  final Color primaryPurple = const Color.fromARGB(255, 50, 41, 117); 

  // --- State untuk PageView ---
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Inisialisasi PageController
    _pageController = PageController();
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller
    _pageController.dispose();
    super.dispose();
  }

  // --- Fungsi Navigasi ---
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        break;
      case 1:
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

  // --- Build Method Utama ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang diatur ke warna abu-abu muda
      backgroundColor: scaffoldBgColor,
      // Hapus SafeArea dari sini
      body: Column(
        children: [
          // 1. Header Ungu (Widget ini sekarang punya background sendiri)
          _buildWelcomeHeader(),
          
          // 2. Sisa Konten (Bisa di-scroll)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24), // Spasi dari header

                  // 2. Kartu Promo Oranye
                  _buildPromoCard(), // <-- WIDGET YANG DIPERBARUI
                  const SizedBox(height: 32),

                  // 3. Judul "Most recommended"
                  _buildSectionTitle('Most recommended'),
                  const SizedBox(height: 16),

                  // 4. Kartu Rekomendasi (Sekarang jadi PageView)
                  _buildRecommendationSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- WIDGET HELPER ---

  /// 1. Widget untuk Header "Welcome" (Sekarang dengan background ungu)
  Widget _buildWelcomeHeader() {
    return Container(
      // Background ungu tua
      color: darkPurple, 
      child: SafeArea( // SafeArea dipindah ke sini
        // Hapus bottom safe area agar menempel dengan konten
        bottom: false, 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    // Teks jadi putih
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                  Text(
                    'Joe Samanta',
                    style: TextStyle(
                      // Teks jadi putih
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/profile_pattern.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 2. Widget untuk Kartu Promo Oranye (SESUAI GAMBAR BARU)
  Widget _buildPromoCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      // Gunakan Stack untuk menumpuk tombol di atas gambar
      child: Stack(
        children: [
          // 1. Latar Belakang (Gambar SVG)
          Container(
            height: 160, // <-- SAYA LEBARKAN: Tinggi diubah dari 140 ke 160
            decoration: BoxDecoration(
              color: orangePromoColor, // <-- Warna oranye tetap sebagai dasar
              borderRadius: BorderRadius.circular(10),
            ),
            // ClipRRect untuk memastikan SVG terpotong sesuai border radius
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Group 1000004670.png', // <-- Path ke file PNG Anda
                fit: BoxFit.cover, // <-- Gambar SVG mengisi penuh (bg full)
                width: double.infinity,
              ),
            ),
          ),
          
          // 2. Tombol "Booking Now" (Di atas gambar)
          Positioned(
            bottom: 16, // Jarak dari bawah
            left: 16,  // Jarak dari kiri (sesuai gambar referensi)
            child: ElevatedButton(
              onPressed: () => _onItemTapped(1),
              style: ElevatedButton.styleFrom(
                backgroundColor: darkPurple, // Tombol warna ungu tua
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Booking Now'),
            ),
          ),
        ],
      ),
    );
  }

  /// 3. Widget untuk Judul Section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: TextStyle(
          color: darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 4. Widget untuk Section Rekomendasi (PageView + Indikator)
  Widget _buildRecommendationSection() {
    // Saya buat 4 item dummy untuk PageView
    final List<String> recommendationImages = [
      'assets/images/gambar2.jpg',
      'assets/images/gambar3.jpg', // Ganti dengan gambar lain jika ada
      'assets/images/gambar4.jpg', // Ganti dengan gambar lain jika ada
      'assets/images/gambar5.jpg', // Ganti dengan gambar lain jika ada
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200, // Tinggi untuk PageView
          child: PageView.builder(
            controller: _pageController,
            itemCount: recommendationImages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              // Menggunakan widget helper baru
              return _buildSingleRecommendationCard(recommendationImages[index]);
            },
          ),
        ),
        const SizedBox(height: 12),
        // Teks di bawah PageView
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Master piece Barbershop – Haircut styling',
            style: TextStyle(
              color: darkTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Indikator Titik
        _buildPageIndicator(itemCount: recommendationImages.length),
      ],
    );
  }

  /// 4a. Helper untuk 1 Kartu Rekomendasi di PageView
  Widget _buildSingleRecommendationCard(String imagePath) {
    return Padding(
      // Beri padding horizontal agar antar item PageView ada jarak
      padding: const EdgeInsets.symmetric(horizontal: 24), 
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image.asset(
              imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () => _onItemTapped(1),
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: const Text('Booking'),
                style: ElevatedButton.styleFrom(
                  // Warna tombol diubah ke ungu tua
                  backgroundColor: darkPurple, 
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 4b. Helper untuk Indikator Halaman (Dots)
  Widget _buildPageIndicator({required int itemCount}) {
    List<Widget> indicators = [];
    for (int i = 0; i < itemCount; i++) {
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          // Lebar 24 jika aktif (jadi garis), 8 jika tidak (jadi titik)
          width: _currentPage == i ? 24.0 : 8.0, 
          decoration: BoxDecoration(
            // Warna ungu jika aktif, abu-abu jika tidak
            color: _currentPage == i ? darkPurple : Colors.grey.shade300, 
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  /// 6. Widget untuk Bottom Navigation Bar (Desain Baru)
  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Container(
        height: 80.0,
        color: cardWhite, // Background Bottom Nav Putih (dari cuplikan)
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            // --- ITEM HOME ---
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), // Ikon sesuai gambar
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
          currentIndex: _selectedIndex, // Gunakan state (di sini 0)
          backgroundColor:
              Colors.transparent, // Transparan agar warna container terlihat
          selectedItemColor:
              darkPurple, // Teks & Ikon Aktif Ungu (dari cuplikan)
          unselectedItemColor:
              inactiveNavColor, // Teks & Ikon Non-Aktif (saya ubah jadi abu)
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