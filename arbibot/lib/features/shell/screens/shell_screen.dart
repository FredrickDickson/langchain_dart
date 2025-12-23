import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;

  const ShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF283039) : const Color(0xFFE5E7EB),
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (index) => _onItemTapped(index, context),
          backgroundColor: isDark ? const Color(0xFF101922) : Colors.white,
          indicatorColor: Colors.transparent,
          destinations: [
            _buildNavItem(Icons.home, 'Home', 0, context),
            _buildNavItem(Icons.folder, 'Library', 1, context),
            _buildNavItem(Icons.history, 'History', 2, context),
            _buildNavItem(Icons.person, 'Profile', 3, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/chats'),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index, BuildContext context) {
    final isSelected = _calculateSelectedIndex(context) == index;
    final color = isSelected ? AppTheme.primaryColor : Colors.grey;
    
    return NavigationDestination(
      icon: Icon(icon, color: color),
      label: label,
      selectedIcon: Icon(icon, color: AppTheme.primaryColor),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/library')) return 1;
    if (location.startsWith('/history') || location.startsWith('/chats')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/library');
        break;
      case 2:
        context.go('/chats');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
