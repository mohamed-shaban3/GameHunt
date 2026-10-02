import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gamehunt/core/theme/colors.dart';
import 'package:gamehunt/features/favorites/presentation/ui/screens/favorites_screen.dart';
import 'package:gamehunt/features/games/presentation/ui/screens/games_screen.dart';
import 'package:gamehunt/features/games/presentation/ui/screens/search_screen.dart';
import 'package:gamehunt/features/profile/presentation/ui/screens/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    GamesScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgDark,
      // استخدام Stack لترك الشاشة تمتد لأسفل الشاشة تماماً خلف البار
      body: Stack(
        children: [
          // 1. الشاشات الأساسية
          IndexedStack(index: _currentIndex, children: _screens),

          // 2. البار الزجاجي العائم
Positioned(
  left: 28,
  right: 28,
  bottom: 20,
  child: SizedBox(
    height: 56, // ارتفاع نحيف وأنيق جداً
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.grid_view_rounded, 'Explore'),
              _buildNavItem(1, Icons.search_rounded, 'Search'),
              _buildNavItem(2, Icons.favorite_rounded, 'Library'),
              _buildNavItem(3, Icons.person_rounded, 'Profile'),
            ],
          ),
        ),
      ),
    ),
  ),
)
        ],
      ),
    );
  }
  Widget _buildNavItem(int index, IconData icon, String label) {
  final isSelected = _currentIndex == index;
  final color = isSelected ? ColorsManager.accentNeon : ColorsManager.textSecondary;

  return InkWell(
    onTap: () => setState(() => _currentIndex = index),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
}
