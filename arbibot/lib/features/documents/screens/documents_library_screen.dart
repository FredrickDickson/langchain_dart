import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class DocumentsLibraryScreen extends StatefulWidget {
  const DocumentsLibraryScreen({super.key});

  @override
  State<DocumentsLibraryScreen> createState() => _DocumentsLibraryScreenState();
}

class _DocumentsLibraryScreenState extends State<DocumentsLibraryScreen> {
  int _selectedTab = 0;
  int _selectedFilter = 0;

  final List<String> _filters = ['All', 'Legal Briefs', 'Contracts', 'CVs', 'Case Law'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
  // final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Library',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: secondaryTextColor),
                  ),
                ],
              ),
            ),

            // Disclaimer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Disclaimer: All AI outputs are drafts and require human verification before use.',
                        style: TextStyle(
                          color: isDark ? Colors.amber[200] : Colors.amber[800],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1C252E) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedTab == 0
                                ? (isDark ? AppTheme.primaryColor : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _selectedTab == 0 && !isDark
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2)]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Drafts',
                              style: TextStyle(
                                color: _selectedTab == 0
                                    ? (isDark ? Colors.white : Colors.black)
                                    : secondaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedTab == 1
                                ? (isDark ? AppTheme.primaryColor : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _selectedTab == 1 && !isDark
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2)]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Finalized',
                              style: TextStyle(
                                color: _selectedTab == 1
                                    ? (isDark ? Colors.white : Colors.black)
                                    : secondaryTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filters
            SizedBox(
              height: 32,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : (isDark ? const Color(0xFF1C252E) : Colors.grey[200]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark ? Colors.grey[300] : Colors.grey[700]),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _DocumentItem(
                    title: 'Non-Disclosure Agreement - Tech Corp',
                    botName: 'DraftBot',
                    time: '2 mins ago',
                    icon: Icons.description,
                    color: Colors.blue,
                    onTap: () => context.push('/document/1'),
                  ),
                  const SizedBox(height: 12),
                  _DocumentItem(
                    title: 'Defense Brief: State v. Jones',
                    botName: 'ResearchBot',
                    time: '1 hour ago',
                    icon: Icons.gavel,
                    color: Colors.purple,
                    onTap: () => context.push('/document/2'),
                  ),
                  const SizedBox(height: 12),
                  _DocumentItem(
                    title: 'Senior Associate CV - John Doe',
                    botName: 'CareerBot',
                    time: 'Yesterday',
                    icon: Icons.work,
                    color: Colors.green,
                    onTap: () => context.push('/document/3'),
                  ),
                  const SizedBox(height: 12),
                  _DocumentItem(
                    title: 'Commercial Lease - Accra Mall',
                    botName: 'DraftBot',
                    time: '2 days ago',
                    icon: Icons.real_estate_agent,
                    color: Colors.orange,
                    onTap: () => context.push('/document/4'),
                  ),
                  const SizedBox(height: 12),
                  _DocumentItem(
                    title: 'Untitled Research Project',
                    botName: 'ResearchBot',
                    time: '3 days ago',
                    icon: Icons.folder_open,
                    color: Colors.grey,
                    isOpacity: true,
                    onTap: () => context.push('/document/5'),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title;
  final String botName;
  final String time;
  final IconData icon;
  final Color color;
  final bool isOpacity;
  final VoidCallback onTap;

  const _DocumentItem({
    required this.title,
    required this.botName,
    required this.time,
    required this.icon,
    required this.color,
    this.isOpacity = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);

    return Opacity(
      opacity: isOpacity ? 0.6 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.transparent : Colors.grey[200]!,
            ),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.smart_toy, size: 14, color: secondaryTextColor),
                        const SizedBox(width: 4),
                        Text(
                          botName,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(color: secondaryTextColor),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: secondaryTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
