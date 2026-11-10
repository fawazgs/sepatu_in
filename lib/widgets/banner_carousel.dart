import 'dart:async';
import 'package:flutter/material.dart';
import '/data/produk_data.dart';
import '/screens/detail_produk_screen.dart';
import '/utils/app_theme.dart';

class BannerItem {
  final String judul;
  final String subjudul;
  final String gambar;
  final String namaProduk;

  const BannerItem({
    required this.judul,
    required this.subjudul,
    required this.gambar,
    required this.namaProduk,
  });
}

const List<BannerItem> _banners = [
  BannerItem(
    judul: 'Nike\nDynamic',
    subjudul: 'Gaya baru, performa maksimal.',
    gambar: 'assets/images/nike_dynamic.png',
    namaProduk: 'Nike Dynamic',
  ),
  BannerItem(
    judul: 'Converse\nAll Star',
    subjudul: 'Gaya klasik untuk segala suasana.',
    gambar: 'assets/images/converse.png',
    namaProduk: 'Converse all star',
  ),
  BannerItem(
    judul: 'Vans Old\nSchool',
    subjudul: 'Gaya jalanan yang nggak pernah pudar',
    gambar: 'assets/images/vans.png',
    namaProduk: 'Vans Old School',
  ),
];

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_controller.hasClients) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _bukaDetail(BannerItem b) async {
    final index = daftarProduk.indexWhere((p) => p.nama == b.namaProduk);
    if (index == -1) return;

    _timer?.cancel();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailProdukScreen(produk: daftarProduk[index]),
      ),
    );
    if (mounted) _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 146,
          child: Listener(
            onPointerDown: (_) => _timer?.cancel(),
            onPointerUp: (_) => _startTimer(),
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) =>
                  setState(() => _current = i % _banners.length),
              itemBuilder: (context, i) {
                final b = _banners[i % _banners.length];
                return GestureDetector(
                  onTap: () => _bukaDetail(b),
                  child: _buildSlide(b),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildDots(),
      ],
    );
  }

  Widget _lingkaran(double ukuran, double alpha) {
    return Container(
      width: ukuran,
      height: ukuran,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: alpha),
      ),
    );
  }

  Widget _buildSlide(BannerItem b) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              gradient: AppGradients.banner,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    bottom: -50,
                    child: _lingkaran(150, 0.08),
                  ),
                  Positioned(
                    left: -25,
                    top: -35,
                    child: _lingkaran(90, 0.06),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              b.judul,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              b.subjudul,
                              style: const TextStyle(
                                color: AppColors.textSoft,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -16,
            child: SizedBox(
              width: 170,
              height: 120,
              child: Image.asset(
                b.gambar,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_banners.length, (i) {
        final aktif = i == _current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: aktif ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: aktif ? AppColors.lime : AppColors.cardSoft,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}