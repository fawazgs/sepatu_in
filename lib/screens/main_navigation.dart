import 'package:flutter/material.dart';
import '/utils/app_theme.dart';
import 'home_screen.dart';
import 'kelola_produk_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      ),
      Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => const KelolaProdukScreen(),
        ),
      ),
      ProfileScreen(onKelolaStok: () => setState(() => _index = 1)),
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        color: AppColors.bgDeep,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_rounded, 'Home'),
                _navItem(1, Icons.inventory_2_outlined, 'Kelola Produk'),
                _navItem(2, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int i, IconData icon, String label) {
    final selected = _index == i;
    final color = selected
        ? AppColors.lime
        : AppColors.textSoft.withValues(alpha: 0.7);
    return InkWell(
      onTap: () => setState(() => _index = i),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }
}