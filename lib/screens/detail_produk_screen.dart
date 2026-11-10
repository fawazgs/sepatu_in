import 'package:flutter/material.dart';
import '/data/produk_data.dart';
import '/utils/app_theme.dart';
import '/utils/format.dart';
import '/widgets/produk_gambar.dart';
import 'form_produk_screen.dart';

class DetailProdukScreen extends StatelessWidget {
  final Produk produk;

  const DetailProdukScreen({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderGambar(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.lime,
                      decorationThickness: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(produk.harga),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lime,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPilLokasi(),
                  const SizedBox(height: 24),
                  _buildPilDeskripsi(),
                  const SizedBox(height: 12),
                  _buildKartuDeskripsi(),
                  const SizedBox(height: 20),
                  _buildTombolEdit(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderGambar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: AppColors.card,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              right: -40,
              bottom: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  color: AppColors.cardHigh,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ProdukGambar(produk.gambar, height: 190),
              ),
            ),
            Positioned(
              left: 20,
              top: 16,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.onLime,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPilLokasi() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, size: 13, color: AppColors.lime),
          const SizedBox(width: 4),
          Text(
            produk.lokasi,
            style: const TextStyle(
              color: AppColors.textSoft,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPilDeskripsi() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Deskripsi',
        style: TextStyle(
          color: AppColors.onLime,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildKartuDeskripsi() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        produk.deskripsi,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: AppColors.textSoft,
          fontSize: 11,
          height: 1.45,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTombolEdit(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 240,
        child: Material(
          color: AppColors.lime,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              final berhasil = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) => FormProdukScreen(produk: produk),
                ),
              );
              if (berhasil == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Center(
                child: Text(
                  'EDIT PRODUK',
                  style: TextStyle(
                    color: AppColors.onLime,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}