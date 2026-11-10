import 'package:flutter/foundation.dart';
class Produk {
  final String nama;
  final int harga;
  final String lokasi;
  final String gambar;
  final String deskripsi;
  final int stok;
  final int stokMinimum;
  final DateTime createdAt;

  const Produk({
    required this.nama,
    required this.harga,
    required this.lokasi,
    required this.gambar,
    required this.deskripsi,
    required this.stok,
    required this.stokMinimum,
    required this.createdAt,
  });
}

final List<Produk> daftarProduk = [
  Produk(
    nama: 'Converse all star',
    harga: 700000,
    lokasi: 'Jakarta',
    gambar: 'assets/images/converse.png',
    deskripsi:
        'Converse All Star adalah sepatu kanvas klasik yang telah menjadi '
        'ikon gaya lintas generasi. Dengan desain sederhana namun timeless, '
        'sepatu ini mudah dipadukan dengan berbagai gaya berpakaian, mulai '
        'dari kasual harian hingga semi-formal. Material kanvas yang ringan '
        'membuatnya nyaman dipakai dalam waktu lama, sementara sol karet '
        'vulkanisir memberikan daya tahan ekstra di setiap langkah.',
    stok: 17,
    stokMinimum: 5,
    createdAt: DateTime(2026, 9, 20),
  ),
  Produk(
    nama: 'Vans Old School',
    harga: 950000,
    lokasi: 'Bandung',
    gambar: 'assets/images/vans.png',
    deskripsi:
        'Vans Old Skool adalah sepatu skate klasik yang telah menjadi ikon '
        'budaya jalanan sejak pertama kali diperkenalkan. Dikenal dengan '
        'signature side stripe yang khas, sepatu ini menggabungkan gaya '
        'kasual dengan daya tahan tinggi. Material suede dan kanvas pada '
        'bagian atas memberikan kesan tangguh, sementara sol karet waffle '
        'menawarkan traksi dan kenyamanan optimal untuk aktivitas '
        'sehari-hari maupun bermain skateboard.',
    stok: 2,
    stokMinimum: 5,
    createdAt: DateTime(2026, 9, 25),
  ),
  Produk(
    nama: 'Nike Unpaired',
    harga: 2000000,
    lokasi: 'Jakarta',
    gambar: 'assets/images/nike_unpaired.png',
    deskripsi:
        'Nike Unpaired hadir dengan desain yang berani dan berbeda dari '
        'yang lain. Mengusung konsep gaya yang tidak terikat aturan, sepatu '
        'ini cocok untuk kamu yang ingin tampil out of the box. Konstruksi '
        'ringan dengan bantalan responsif memberikan kenyamanan maksimal, '
        'sementara detail desainnya yang unik membuat setiap langkah jadi '
        'pernyataan gaya tersendiri.',
    stok: 8,
    stokMinimum: 5,
    createdAt: DateTime(2026, 10, 2),
  ),
  Produk(
    nama: 'Nike Dynamic',
    harga: 3000000,
    lokasi: 'Bogor',
    gambar: 'assets/images/nike_dynamic.png',
    deskripsi:
        'Nike Dynamic dirancang untuk mereka yang selalu bergerak aktif. '
        'Dengan teknologi bantalan responsif, sepatu ini memberikan '
        'kenyamanan maksimal baik untuk aktivitas harian maupun olahraga '
        'ringan. Material upper yang breathable menjaga kaki tetap sejuk, '
        'sementara desainnya yang modern membuatnya cocok dipadukan dengan '
        'berbagai gaya berpakaian.',
    stok: 24,
    stokMinimum: 5,
    createdAt: DateTime(2026, 10, 8),
  ),
  Produk(
    nama: 'Chelsea Boot',
    harga: 1500000,
    lokasi: 'Bandung',
    gambar: 'assets/images/chelsea.png',
    deskripsi:
        'Chelsea Boot adalah sepatu bot klasik dengan desain minimalis '
        'namun elegan. Ciri khasnya yang tanpa tali dan elastic panel di '
        'bagian samping membuatnya mudah dipakai-lepas, sementara siluetnya '
        'yang ramping cocok dipadukan baik dengan outfit kasual maupun '
        'semi-formal. Material kulit berkualitas memberikan kesan premium '
        'sekaligus daya tahan jangka panjang.',
    stok: 3,
    stokMinimum: 5,
    createdAt: DateTime(2026, 10, 5),
  ),
  Produk(
    nama: 'Adidas Star',
    harga: 1000000,
    lokasi: 'Depok',
    gambar: 'assets/images/adidas.png',
    deskripsi:
        'Adidas Star menghadirkan perpaduan gaya klasik dan modern dalam '
        'satu desain. Dengan siluet yang bersih dan detail tiga garis khas '
        'Adidas, sepatu ini menjadi pilihan serbaguna untuk berbagai '
        'aktivitas sehari-hari. Material upper yang nyaman dipadukan dengan '
        'sol yang ringan membuat setiap langkah terasa ringan tanpa '
        'mengorbankan gaya.',
    stok: 31,
    stokMinimum: 5,
    createdAt: DateTime(2026, 9, 28),
  ),
];

final ValueNotifier<int> produkNotifier = ValueNotifier<int>(0);