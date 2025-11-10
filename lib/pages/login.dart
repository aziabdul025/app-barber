import 'package:flutter/material.dart';
import 'package:Barber/pages/home.dart'; // <-- 1. IMPORT DITAMBAHKAN

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State untuk mengelola visibilitas password
  bool _isPasswordVisible = false;
  // State untuk checkbox "Remember me"
  bool _rememberMe = false;

  // Controller untuk mengisi teks awal seperti di gambar
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Jangan lupa dispose controller saat widget tidak lagi digunakan
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk toggle visibilitas password
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2C1E4A), // Warna ungu tua (atas)
              Color(0xFF4A3482), // Warna ungu sedikit lebih terang (bawah)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // ================== STRUKTUR BARU UNTUK TENGAH ==================
        
        // 1. Gunakan SafeArea
        child: SafeArea(
          // 2. Gunakan Center untuk menengahkan semua konten
          child: Center(
            // 3. Gunakan SingleChildScrollView agar bisa di-scroll
            child: SingleChildScrollView(
              // Beri padding di sekeliling konten
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              
              child: Column(
                // 4. Tengahkan semua anak (teks dan kartu) secara horizontal
                crossAxisAlignment: CrossAxisAlignment.center,
                // 5. Tengahkan juga secara vertikal
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  // 6. Teks "Log in" (sekarang di tengah)
                  Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  // 7. Beri jarak antara Teks dan Kartu
                  const SizedBox(height: 32.0),

                  // 8. Kartu login
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      // PENTING: Kolom di dalam kartu TETAP rata kiri
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Label Email
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8.0),
                        
                        // Input Field Email
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16.0),

                        // Label Password
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8.0),
                        
                        // Input Field Password
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[600],
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Baris untuk "Remember me"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.purple,
                                    checkColor: Colors.white,
                                    side: const BorderSide(color: Colors.white54),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),

                        // Tombol Log In
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 164, 76, 242),
                                const Color.fromARGB(255, 152, 68, 224),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // --- 2. NAVIGASI DITAMBAHKAN ---
                              // Menggunakan pushReplacement agar pengguna tidak bisa "kembali"
                              // ke halaman login setelah berhasil login.
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                              );
                              // --------------------------------
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Log In', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // ================================================================
      ),
    );
  }
}