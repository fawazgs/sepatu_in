import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '/data/produk_data.dart';
import '/utils/app_theme.dart';
import '/widgets/produk_gambar.dart';

const double _lebarField = 240;

class FormProdukScreen extends StatefulWidget {
  final Produk? produk;

  const FormProdukScreen({super.key, this.produk});

  @override
  State<FormProdukScreen> createState() => _FormProdukScreenState();
}

class _FormProdukScreenState extends State<FormProdukScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late final TextEditingController _namaC;
  late final TextEditingController _hargaC;
  late final TextEditingController _alamatC;
  late final TextEditingController _deskripsiC;
  String? _gambarPath;

  bool get _modeEdit => widget.produk != null;

  @override
  void initState() {
    super.initState();
    final p = widget.produk;
    _namaC = TextEditingController(text: p?.nama ?? '');
    _hargaC = TextEditingController(text: p?.harga.toString() ?? '');
    _alamatC = TextEditingController(text: p?.lokasi ?? '');
    _deskripsiC = TextEditingController(text: p?.deskripsi ?? '');
    _gambarPath = p?.gambar;
  }

  @override
  void dispose() {
    _namaC.dispose();
    _hargaC.dispose();
    _alamatC.dispose();
    _deskripsiC.dispose();
    super.dispose();
  }

  Future<void> _pilihFoto(ImageSource sumber) async {
    final file = await _picker.pickImage(
      source: sumber,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (file != null && mounted) {
      setState(() => _gambarPath = file.path);
    }
  }

  void _tampilPilihanFoto() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Pilih dari galeri'),
              onTap: () {
                Navigator.pop(ctx);
                _pilihFoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Ambil foto'),
              onTap: () {
                Navigator.pop(ctx);
                _pilihFoto(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(teks), duration: const Duration(seconds: 2)),
      );
  }

  // CREATE dan UPDATE
  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    if (_gambarPath == null) {
      _pesan('Pilih foto produk dulu');
      return;
    }

    final lama = widget.produk;
    final baru = Produk(
      nama: _namaC.text.trim(),
      harga: int.parse(_hargaC.text.trim()),
      lokasi: _alamatC.text.trim(),
      gambar: _gambarPath!,
      deskripsi: _deskripsiC.text.trim(),
      stok: lama?.stok ?? 10,
      stokMinimum: lama?.stokMinimum ?? 5,
      createdAt: lama?.createdAt ?? DateTime.now(),
    );

    if (lama == null) {
      daftarProduk.insert(0, baru);
    } else {
      final i = daftarProduk.indexOf(lama);
      if (i != -1) daftarProduk[i] = baru;
    }
    produkNotifier.value++;

    _pesan(lama == null ? 'Produk berhasil ditambahkan' : 'Produk diperbarui');
    Navigator.of(context).pop(true);
  }

  // DELETE
  Future<void> _hapus() async {
    final p = widget.produk;
    if (p == null) return;

    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus produk?'),
        content: Text('${p.nama} akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (yakin != true) return;

    daftarProduk.remove(p);
    produkNotifier.value++;

    if (!mounted) return;
    _pesan('Produk dihapus');
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTombolKembali(),
                const SizedBox(height: 20),
                Center(child: _buildKotakFoto()),
                const SizedBox(height: 32),
                _buildField(
                  label: 'Nama Produk :',
                  controller: _namaC,
                  validator: _wajib,
                ),
                _buildField(
                  label: 'Harga Produk :',
                  controller: _hargaC,
                  keyboard: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _validasiHarga,
                ),
                _buildField(
                  label: 'Alamat :',
                  controller: _alamatC,
                  validator: _wajib,
                ),
                _buildField(
                  label: 'Deskripsi Produk :',
                  controller: _deskripsiC,
                  minLines: 6,
                  maxLines: 6,
                  validator: _wajib,
                ),
                const SizedBox(height: 28),
                Center(child: _buildTombolSimpan()),
                if (_modeEdit) ...[
                  const SizedBox(height: 12),
                  Center(child: _buildTombolHapus()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _wajib(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  String? _validasiHarga(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    final angka = int.tryParse(v.trim());
    if (angka == null || angka <= 0) return 'Harga tidak valid';
    return null;
  }

  Widget _buildTombolKembali() {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: AppColors.lime,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.chevron_left_rounded,
            color: AppColors.onLime, size: 24),
      ),
    );
  }

  Widget _buildKotakFoto() {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _tampilPilihanFoto,
      child: Container(
        width: 267,
        height: 185,
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.lime, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _gambarPath == null
            ? const Icon(Icons.photo_camera_outlined,
                size: 72, color: AppColors.lime)
            : ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: ProdukGambar(_gambarPath!, fit: BoxFit.contain),
              ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboard,
    List<TextInputFormatter>? formatters,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSoft,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: _lebarField,
            child: TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboard,
              inputFormatters: formatters,
              minLines: minLines,
              maxLines: maxLines,
              cursorColor: AppColors.lime,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColors.card,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.lime, width: 1.5),
                ),
                errorStyle:
                    const TextStyle(fontSize: 11, color: AppColors.danger),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTombolSimpan() {
    return SizedBox(
      width: 160,
      child: Material(
        color: AppColors.lime,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: _simpan,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'SIMPAN',
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
    );
  }

  Widget _buildTombolHapus() {
    return SizedBox(
      width: 160,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: _hapus,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                'HAPUS PRODUK',
                style: TextStyle(
                  color: AppColors.danger,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}