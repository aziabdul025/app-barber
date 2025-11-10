import 'package:Barber/pages/payment.dart';
import 'package:flutter/material.dart';
// Asumsikan PaymentScreen berada di lib/payment_screen.dart
import 'package:Barber/pages/payment.dart'; 

// --- Definisikan Warna Utama ---
const Color kDarkPurple = Color(0xFF30195C); // Warna background utama
const Color kButtonPurple = Color(0xFF8B5CF6); // Warna tombol "Booking Now"
const Color kFieldBackground = Colors.white; // Warna background field input
const Color kTextWhite = Colors.white;
const Color kTextGrey = Colors.white70; // Warna untuk teks label/subjudul
const Color kGreenDiscount = Color(0xFF4ADE80); // Warna untuk teks diskon

// --- Halaman Utama ---
class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  // Variabel state untuk melacak waktu yang dipilih
  String _selectedTime = '08:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPurple,
      // 1. App Bar
      appBar: AppBar(
        backgroundColor: kDarkPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextWhite),
          onPressed: () {
            // Aksi tombol kembali
            Navigator.of(context).pop();
          },
        ),
        
        title: const Text(
          'Booking',
          style: TextStyle(color: kTextWhite, fontWeight: FontWeight.bold),
        ),
      ),
      // 2. Body Utama
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Bagian Tanggal & Waktu ---
              _buildDateTimeSection(),
              const SizedBox(height: 24),

              // --- Bagian Form Input ---
              _buildTextField(label: 'Name', initialValue: 'Jannah'),
              const SizedBox(height: 16),
              _buildTextField(label: 'Email', initialValue: 'User@gmail.com'),
              const SizedBox(height: 16),
              _buildTextField(label: 'No. Hp', initialValue: '0832141278'),
              const SizedBox(height: 24),

              // --- Bagian Ringkasan Pembayaran ---
              _buildPaymentSummary(),
              const SizedBox(height: 32),

              // --- Tombol Booking Now ---
              _buildBookingButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  /// Widget untuk menampilkan bagian "Date & time"
  Widget _buildDateTimeSection() {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined, color: kTextGrey, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Date & time',
              style: TextStyle(color: kTextGrey, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Sun, 15 Jan - 08:00 AM',
              style: TextStyle(
                color: kTextWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Widget untuk membuat Form Input (Nama, Email, No. Hp)
  Widget _buildTextField({required String label, required String initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: kTextGrey, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            filled: true,
            fillColor: kFieldBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  /// Widget untuk menampilkan bagian "Payment summary"
  Widget _buildPaymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment summary',
          style: TextStyle(
            color: kTextWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Baris 1: Basic haircut
        _buildSummaryRow('Basic haircut', '\$20'),
        const SizedBox(height: 8),
        // Baris 2: Extra massage
        _buildSummaryRow('Extra massage', '\$10'),
        const SizedBox(height: 8),
        // Baris 3: Membership Diskon (dengan warna hijau)
        _buildSummaryRow(
          'Membership Diskon',
          '10%',
          valueColor: kGreenDiscount,
        ),
        // Garis Pemisah
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(color: kTextGrey),
        ),
        // Baris Total: Service fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Service fee',
              style: TextStyle(
                color: kTextWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$25', // Asumsi total setelah diskon
              style: TextStyle(
                color: kTextWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Widget helper kecil untuk baris di "Payment summary"
  Widget _buildSummaryRow(String title, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: kTextGrey, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? kTextWhite,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Widget untuk tombol "Booking Now"
  Widget _buildBookingButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // --- NAVIGASI KE PAYMENT SCREEN ---
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PaymentPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kButtonPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Booking Now',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kTextWhite,
          ),
        ),
      ),
    );
  }
}