import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class ProdukGambar extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color warnaError;

  const ProdukGambar(
    this.path, {
    super.key,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.warnaError = Colors.white54,
  });

  Widget _error() =>
      Center(child: Icon(Icons.image_not_supported, color: warnaError));

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('assets/')) {
      return Image.asset(path,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _error());
    }
    if (kIsWeb) {
      return Image.network(path,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _error());
    }
    return Image.file(File(path),
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => _error());
  }
}