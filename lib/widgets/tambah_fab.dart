import 'package:flutter/material.dart';
import '/screens/form_produk_screen.dart';
import '/utils/app_theme.dart';

class TambahFab extends StatelessWidget {
  const TambahFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const FormProdukScreen()),
      ),
      backgroundColor: AppColors.lime,
      foregroundColor: AppColors.onLime,
      elevation: 6,
      icon: const Icon(Icons.add_rounded),
      label: const Text(
        'Tambah',
        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.3),
      ),
    );
  }
}