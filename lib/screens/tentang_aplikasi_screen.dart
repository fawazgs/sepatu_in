import 'package:flutter/material.dart';
import '/utils/app_theme.dart';
import '/widgets/sepatu_logo.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: AppColors.onLime, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              const Center(
                child: SepatuLogo(
                  fontSize: 40,
                  underline: true,
                  fontWeight: FontWeight.w900,
                  extraBold: true,
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'Versi 1.0.0',
                  style: TextStyle(color: AppColors.textSoft, fontSize: 12),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Sepatu.in adalah aplikasi manajemen produk sepatu yang '
                'dirancang untuk membantu admin toko mengelola data produk '
                'dengan mudah, mulai dari menambah, melihat, mengubah, hingga '
                'menghapus data sepatu.',
                style: TextStyle(
                    fontSize: 13, height: 1.6, color: AppColors.textSoft),
              ),
              const SizedBox(height: 16),
              const Text(
                'Aplikasi ini dikembangkan sebagai tugas mata kuliah '
                'Mobile Programming, Jurusan Ilmu Komputer.',
                style: TextStyle(
                    fontSize: 13, height: 1.6, color: AppColors.textSoft),
              ),
            ],
          ),
        ),
      ),
    );
  }
}