import 'package:flutter/material.dart';
import '/data/produk_data.dart';
import '/utils/app_theme.dart';
import '/utils/format.dart';
import '/widgets/produk_list_item.dart';
import '/widgets/tambah_fab.dart';
import 'detail_produk_screen.dart';

class KelolaProdukScreen extends StatefulWidget {
  const KelolaProdukScreen({super.key});

  @override
  State<KelolaProdukScreen> createState() => _KelolaProdukScreenState();
}

class _KelolaProdukScreenState extends State<KelolaProdukScreen> {
  @override
  void initState() {
    super.initState();
    produkNotifier.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    produkNotifier.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      floatingActionButton: const TambahFab(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Kelola Produk',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.lime,
                  decorationThickness: 3,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.lime,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Semua',
                  style: TextStyle(
                    color: AppColors.onLime,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 90),
                  itemCount: daftarProduk.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final p = daftarProduk[i];
                    return ProdukListItem(
                      nama: p.nama,
                      harga: formatRupiah(p.harga),
                      lokasi: p.lokasi,
                      gambar: p.gambar,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailProdukScreen(produk: p),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}