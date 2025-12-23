import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuAni0iT2dCAZL8HNGXs3IlF5608Apu3kHkkR7ieWhPeb13nYn2snDlwdXdjIFionz9-dF4h-VGgJYT_Zm8_2jj-oj7drYzOG8McvWQibmIsEQhIMpbRjYI8eI5uLE1prE0LKF8wqGS47IvI1HgSrMWlvbPvgTvRqfVYx4VXvMhhoMZ2kYLtJ4D01QQqFk1AM8X8XxXzQAdhLzBduFUIH19EwXPtPS2Nk53Tw9G8j8V9dQBT3kR6w4HFYamUGAJZpf1tdhbXnAKGI_k',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kwame Mensah',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Professional Plan',
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    foregroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Manage'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Account & Security
          _SettingsGroup(
            title: 'Account & Security',
            children: [
              _SettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {},
                iconColor: AppTheme.primaryColor,
              ),
              _SettingsTile(
                icon: Icons.fingerprint,
                title: 'Biometric Login',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeTrackColor: AppTheme.primaryColor,
                ),
                iconColor: AppTheme.primaryColor,
              ),
            ],
          ),

          // Privacy & Data
          _SettingsGroup(
            title: 'Privacy & Data',
            children: [
              _SettingsTile(
                icon: Icons.security,
                title: 'Privacy Controls',
                subtitle: 'Manage data sharing & analytics',
                onTap: () {},
                iconColor: Colors.blue,
              ),
              _SettingsTile(
                icon: Icons.delete,
                title: 'Request Data Deletion',
                onTap: () {},
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
            ],
          ),

          // Legal & Compliance
          _SettingsGroup(
            title: 'Legal & Compliance',
            children: [
              _SettingsTile(
                icon: Icons.gavel,
                title: 'Terms of Service',
                onTap: () {},
                iconColor: Colors.orange,
              ),
              _SettingsTile(
                icon: Icons.warning,
                title: 'Disclaimer',
                subtitle: 'AI outputs are draft-only & require review',
                onTap: () {},
                iconColor: Colors.amber,
              ),
              _SettingsTile(
                icon: Icons.balance,
                title: 'AI Ethics Policy',
                onTap: () {},
                iconColor: Colors.purple,
              ),
            ],
          ),

          // Support
          _SettingsGroup(
            title: 'Support',
            children: [
              _SettingsTile(
                icon: Icons.help,
                title: 'Help Center',
                onTap: () {},
                iconColor: Colors.green,
              ),
              _SettingsTile(
                icon: Icons.bug_report,
                title: 'Report a Bug',
                onTap: () {},
                iconColor: Colors.teal,
              ),
            ],
          ),

          const SizedBox(height: 24),
          
          // Logout
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () => context.go('/login'),
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: surfaceColor,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          Center(
            child: Text(
              'ArbiBot v1.0.2',
              style: TextStyle(color: secondaryTextColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1C252E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color iconColor;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    required this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? (isDark ? Colors.white : const Color(0xFF111418)),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588),
                fontSize: 12,
              ),
            )
          : null,
      trailing: trailing ?? Icon(
        Icons.chevron_right,
        color: isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588),
      ),
    );
  }
}
