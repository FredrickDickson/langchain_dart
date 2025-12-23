import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arbibot/features/common/repositories/database_repository.dart';
import 'package:arbibot/features/auth/repositories/auth_repository.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Map<String, dynamic>? _profile;
  int _chatCount = 0;
  int _documentCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() => _isLoading = true);
    try {
      final userId = ref.read(authRepositoryProvider).currentUser?.id;
      if (userId != null) {
        final dbRepo = ref.read(databaseRepositoryProvider);
        final profile = await dbRepo.getProfile(userId);
        final chats = await dbRepo.getChats(userId);
        final documents = await dbRepo.getDocuments(userId);
        
        if (mounted) {
          setState(() {
            _profile = profile;
            _chatCount = chats.length;
            _documentCount = documents.length;
            _isLoading = false;
          });
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    final userName = _profile?['full_name'] ?? 'User';
    final userEmail = _profile?['email'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primaryColor),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadProfileData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Profile Header
                  Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          border: Border.all(
                            color: AppTheme.primaryColor.withValues(alpha: 0.2),
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userName,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (userEmail.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.chat,
                          count: _chatCount.toString(),
                          label: 'Chats',
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.description,
                          count: _documentCount.toString(),
                          label: 'Documents',
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Menu Items
                  Container(
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _ProfileMenuItem(
                          icon: Icons.chat_bubble_outline,
                          title: 'My Chats',
                          onTap: () => context.push('/chats'),
                        ),
                        _ProfileMenuItem(
                          icon: Icons.folder_outlined,
                          title: 'My Documents',
                          onTap: () => context.push('/documents'),
                        ),
                        _ProfileMenuItem(
                          icon: Icons.badge_outlined,
                          title: 'CV Builder',
                          onTap: () => context.push('/cv/profile'),
                        ),
                        _ProfileMenuItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                          onTap: () => context.push('/settings'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  TextButton.icon(
                    onPressed: () async {
                      await ref.read(authRepositoryProvider).signOut();
                      if (context.mounted) {
                        context.go('/welcome');
                      }
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text('Log Out', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String count;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C252E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF283039) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF111418),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF111418),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588),
      ),
    );
  }
}
