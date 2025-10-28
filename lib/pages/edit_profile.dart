import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini untuk SystemUiOverlayStyle

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // State untuk visibilitas password
  bool _isPasswordVisible = false;

  // Controller (jika ingin mengambil nilai dari input)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Definisikan warna ungu
  final Color darkPurple = const Color(0xFF2C1E4A);
  // Definisikan warna abu-abu muda untuk background
  final Color lightGrayBg = const Color(0xFFF5F5F5);

  @override
  void initState() {
    super.initState();
    // Isi nilai awal (opsional)
    _emailController.text = 'Jannah@gmail.com';
    _passwordController.text = '********';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi toggle password
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Atur tema App Bar di sini agar konsisten
    final appBarTheme = AppBarTheme(
      backgroundColor: lightGrayBg, // Warna app bar sama
      elevation: 0, // Tanpa bayangan
      iconTheme: const IconThemeData(color: Colors.black), // Ikon back hitam
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      systemOverlayStyle: SystemUiOverlayStyle.dark, // Status bar icons hitam
    );


    return Scaffold(
      backgroundColor: lightGrayBg, // Gunakan warna background yang sudah didefinisikan
      appBar: AppBar(
        // Tombol back otomatis muncul jika halaman ini dipanggil via Navigator.push
         leading: IconButton(
           icon: const Icon(Icons.arrow_back, color: Colors.black),
           onPressed: () => Navigator.of(context).pop(), // Kembali ke halaman sebelumnya
         ),
        title: const Text('Account'),
        centerTitle: true, // Judul di tengah
        // Terapkan tema App Bar
        backgroundColor: appBarTheme.backgroundColor,
        elevation: appBarTheme.elevation,
        iconTheme: appBarTheme.iconTheme,
        titleTextStyle: appBarTheme.titleTextStyle,
        systemOverlayStyle: appBarTheme.systemOverlayStyle,

        // ================== PERUBAHAN DI SINI ==================
        // Tambahkan tinggi AppBar (defaultnya sekitar 56)
        toolbarHeight: 80.0, // <-- Ubah nilai ini untuk menaikkan/menurunkan
        // =======================================================
      ),
      body: SingleChildScrollView( // Agar bisa di-scroll
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan item secara horizontal
            children: [
              const SizedBox(height: 20), // Jarak dari app bar

              // Foto Profil
              const CircleAvatar(
                radius: 50,
                 // Ganti dengan gambar profil Anda
                 backgroundImage: AssetImage('assets/images/profile_pattern.png'), // Contoh
              ),
              const SizedBox(height: 12),

              // Badge Platinum
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'Platinum',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              // Nama User
              const Text(
                'Jannah',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40), // Jarak ke input fields

              // Input Field Email
              _buildTextField(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Input Field Password
              _buildTextField(
                label: 'Password',
                controller: _passwordController,
                icon: Icons.lock_outline, // Ikon kunci yang lebih pas
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey[600], // Sedikit lebih gelap
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              const SizedBox(height: 50), // Jarak ke tombol Save

              // Tombol Save
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol Save ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple, // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget helper untuk membuat TextField
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700], // Sedikit lebih gelap agar kontras
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500), // Warna teks input
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon, color: Colors.grey[600], size: 20 // Sedikit lebih gelap
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white, // Background field putih
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade400), // Border abu-abu sedikit lebih gelap
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade400), // Border saat tidak aktif
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: darkPurple, width: 1.5), // Border saat aktif
            ),
          ),
        ),
      ],
    );
  }
}