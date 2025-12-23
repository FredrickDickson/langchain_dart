import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class SourceViewerScreen extends StatelessWidget {
  final String sourceId;

  const SourceViewerScreen({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
  // final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              'Electronic Transactions Act',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '2008 (Act 772)',
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.ios_share, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Sticky Metadata Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.backgroundDark.withValues(alpha: 0.95) : AppTheme.backgroundLight.withValues(alpha: 0.95),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.find_in_page, color: AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENT SECTION',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'Section 13 • Page 14',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Pg 14/82',
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Previous Context
                  Opacity(
                    opacity: 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '12. (1) Where a law requires information to be in writing, that requirement is met by an electronic record if the information contained in the electronic record is accessible and is capable of being retained for subsequent reference.',
                          style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '(2) Subsection (1) applies whether the requirement for the information to be in writing is in the form of an obligation or whether the law provides consequences for the information not being in writing.',
                          style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Highlighted Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      border: const Border(
                        left: BorderSide(color: AppTheme.primaryColor, width: 4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SECTION 13 HIGHLIGHT',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Icon(Icons.verified, color: AppTheme.primaryColor, size: 18),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '13. (1) Where a law requires the signature of a person, that requirement is met in relation to an electronic communication if',
                          style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '(a) a method is used to identify the person and to indicate that person\'s approval of the information contained in the electronic communication; and',
                                style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '(b) the method is as reliable as is appropriate for the purpose for which the electronic communication was generated or communicated, in the light of all the circumstances, including any relevant agreement.',
                                style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Following Context
                  Opacity(
                    opacity: 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '14. (1) Where a law requires information to be presented or retained in its original form, that requirement is met by an electronic record if',
                          style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '(a) there exists a reliable assurance as to the integrity of the information from the time when it was first generated in its final form as an electronic record or otherwise; and',
                          style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '(b) where it is required that information be presented, that information is capable of being displayed to the person to whom it is to be presented.',
                          style: TextStyle(color: textColor, fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.backgroundDark : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.content_copy, size: 20),
                    label: const Text('Copy Citation (OSCOLA)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Draft only. Always verify with the official gazette.',
                  style: TextStyle(color: secondaryTextColor, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
