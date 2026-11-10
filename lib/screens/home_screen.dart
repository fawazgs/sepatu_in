import 'package:flutter/material.dart';
import '/data/produk_data.dart';
import '/utils/app_theme.dart';
import '/utils/format.dart';
import '/widgets/banner_carousel.dart';
import '/widgets/sepatu_card.dart';
import '/widgets/sepatu_logo.dart';
import '/widgets/tambah_fab.dart';
import 'detail_produk_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _filterIndex = 0;
  final List<String> _filters = ['Semua', 'Terbaru', 'Stok Terbatas !'];

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

  List<Produk> get _produkTampil {
    final list = List<Produk>.from(daftarProduk);
    switch (_filterIndex) {
      case 1: 
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return list;
      case 2:
        return list.where((p) => p.stok <= p.stokMinimum).toList();
      default:
        return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final produk = _produkTampil;

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
              const SepatuLogo(fontSize: 22),
              const SizedBox(height: 8),
              const BannerCarousel(),
              const SizedBox(height: 16),
              _buildFilters(),
              const SizedBox(height: 20),
              Expanded(
                child: produk.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada produk di kategori ini',
                          style: TextStyle(color: AppColors.textSoft),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: produk.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, i) {
                          final p = produk[i];
                          return SepatuCard(
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

  Widget _buildFilters() {
    return Row(
      children: List.generate(_filters.length, (i) {
        final selected = i == _filterIndex;
        return GestureDetector(
          onTap: () => setState(() => _filterIndex = i),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: selected ? AppColors.lime : AppColors.chip,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _filters[i],
              style: TextStyle(
                color: selected ? AppColors.onLime : AppColors.textSoft,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }),
    );
  }
}