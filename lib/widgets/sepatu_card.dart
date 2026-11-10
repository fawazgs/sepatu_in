import 'package:flutter/material.dart';
import '/utils/app_theme.dart';
import 'produk_gambar.dart';

class SepatuCard extends StatelessWidget {
  final String nama;
  final String harga;
  final String lokasi;
  final String gambar;
  final VoidCallback? onTap;

  const SepatuCard({
    super.key,
    required this.nama,
    required this.harga,
    required this.lokasi,
    required this.gambar,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  harga,
                  style: const TextStyle(
                    color: AppColors.lime,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 12, color: AppColors.textSoft),
                    const SizedBox(width: 2),
                    Text(
                      lokasi,
                      style: const TextStyle(
                          color: AppColors.textSoft, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                color: AppColors.cardHigh,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -6,
            top: -8,
            child: SizedBox(
              width: 95,
              height: 70,
              child: ProdukGambar(gambar),
            ),
          ),
        ],
      ),
    );
  }
}