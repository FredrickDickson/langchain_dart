import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
  // final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primaryColor, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAzp2bCHaTH2pdebscSzEsj--RzYgkIaOTxgqyNxxPikd1zpkD2U7h9RCgPZ2KC7fIgCTOsqGRqeb6qYu3nJUSX3-YfxQTl9SM-4DvsTtLHoE345xEafV4TLY3ac6nYCrY0pBuQ0inUppM_Se-j0a07uKQWNA0L7DlviwmdcrvnQSTj0OBCcNTKvEBhaWuyZYTXrqhzKboX35Lt255Akip8GUnsPizxcb61xhc2eEHej8cBi4vHGcoeLER_QlORlH7mbLTc7OBrL6Q',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'ArbiBot',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/settings'),
                    icon: Icon(Icons.settings, color: textColor),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trust Disclaimer Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C2127),
                          borderRadius: BorderRadius.circular(12),
                          border: const Border(left: BorderSide(color: Colors.amber, width: 4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.warning_amber_rounded, color: Colors.amber),
                                const SizedBox(width: 8),
                                const Text(
                                  'Important Notice',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'ArbiBot is an AI assistant. All outputs are drafts and must be reviewed by a qualified legal professional.',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Quick Actions',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Quick Actions Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 4 / 3,
                        children: [
                          _QuickActionCard(
                            title: 'Legal Research',
                            icon: Icons.search,
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBj8qzvT8S40hbOPdZLA4Vm2VCNeJAnG5dMHKBt9fSj6H3jF5C8d8ynJ6FYmrVTipaFBHggQOUFf4ZP2XbD-93fSaAmrbnaHW8fc_17bGSERL7bMz7EuP--IvSk5oK23Dmg2U9ZZ4Piv-2hOLPPkQkovcUd9jWlMSkIQoaUMxxlm8oJekLK9ZGnKgkvIcOXWsJ2u8VmhXcpj8RitPCeOjJ9Kc3UKxWpVMB9_b1981A52Y236AUtCijoHM9pFYKsh2EWNU2s8aYAxsY',
                            onTap: () => context.push('/research'),
                          ),
                          _QuickActionCard(
                            title: 'Draft Document',
                            icon: Icons.edit_document,
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD6z-UzN_bZ2oF9T8pZur8MXAo3qVrxlcdq14kLcSGo6Fo5WUv9Zkvv_2Bq-zZDR30lc63AXZDG4Ixl_qD5SGLTkrxm_REwJCSm4x-0siFVRpK1xHBJl_YX8w2LKE0XlJS3w9xM0Qp5nyDG04LBc948b1xiiBCr90Kzx7IGyDqPQCQ1YZUkApF18lZz_qNZPdOu49XTSn-JrCe3yX3MA-n8a8SWQmwYoVYTmKqPPC3OnTRrha7ugdmK153bovRHd7HQCxKARuO2050',
                            onTap: () => context.push('/draft/new'),
                          ),
                          _QuickActionCard(
                            title: 'CV Builder',
                            icon: Icons.badge,
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCRYLpTPRTSwWb3vEOdJ8L_Ewt_e6H7SB_IKev3M1vPRq6vKZ-fQEAgP7_Le7XC37eWa7D1p-fT9h1mMr9m61lfAk3UIAOMJvnj0qV_OXk6Fx31Tsg3XFlrUwS1zr7KXowQcJSs3IuU1pzzXJmT5I3v5JjPQ6G36SraEw5V1umnsrGEqYJqZR2zvwAd5WGJh0b7u6gOLnGrjiyGIKclhPTuswfNmdQp5Z0m0a_o_9rt5PspDu_LGfG_HKt_u4OS0vA_EdSxpfQsp9o',
                            onTap: () => context.push('/cv/profile'),
                          ),
                          _QuickActionCard(
                            title: 'Discovery',
                            icon: Icons.public,
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBnJwzkTkFWzzbt35AY0rPi8gU7kS3tFJRtfGH3gXhavZGsyRz-AI5PjPK7paBmo1pVn3onaD2arwv7cCP1ZMv2DFbzn6BsL_2TMIughbo_lVrVSHjGzhtdselNxJf9NXya1EJ-HHAnUETJ4W3YZlb7hfkq4HidVLJ6hQ-fL6ThyFrPiGr-FCciw-3H7vz9jI6mY53ZYBK_QqnqYR43y_CQZ9Y4sXZ1kN09sJZD-OLoQSyYgrcKqx5raDPi-0Fk-VVjHe4T4CnYmKQ',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Sessions',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                    ),
                    
                    // Recent Sessions List
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _RecentSessionItem(
                            title: 'Land Dispute Research',
                            subtitle: '2h ago • Case Law Search',
                            icon: Icons.gavel,
                            color: AppTheme.primaryColor,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 8),
                          _RecentSessionItem(
                            title: 'Tenancy Agreement',
                            subtitle: 'Yesterday • Document Draft',
                            icon: Icons.history_edu,
                            color: Colors.purple,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 8),
                          _RecentSessionItem(
                            title: 'Corporate Tax Inquiry',
                            subtitle: '3 days ago • Research',
                            icon: Icons.person_search,
                            color: Colors.green,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String imageUrl;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryColor.withValues(alpha: 0.2),
                    const Color(0xFF101922).withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: AppTheme.primaryColor, size: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentSessionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _RecentSessionItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2127) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF111418),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
