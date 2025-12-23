import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';

class DraftPreviewScreen extends StatelessWidget {
  const DraftPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;
    final backgroundColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Draft Preview',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  // Safety Banner
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Draft – Not Legal Advice',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'This content is AI-generated. It should be reviewed by a qualified legal professional before use.',
                                  style: TextStyle(
                                    color: isDark ? Colors.amber[200] : Colors.amber[800],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Document Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Document Header
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'CONTRACT LAW',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '•',
                                    style: TextStyle(color: secondaryTextColor),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Generated by ArbiBot',
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Employment Contract Agreement',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.schedule, size: 16, color: secondaryTextColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Draft created 2 mins ago',
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

                        // Document Body
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  children: [
                                    const TextSpan(text: 'This '),
                                    TextSpan(
                                      text: 'EMPLOYMENT AGREEMENT',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const TextSpan(text: ' (the "Agreement") is made and entered into on '),
                                    WidgetSpan(child: _PlaceholderSpan('[Date]')),
                                    const TextSpan(text: ', by and between '),
                                    WidgetSpan(child: _PlaceholderSpan('[Employer Name]')),
                                    const TextSpan(text: ', a company organized and existing under the laws of the Republic of Ghana, with its principal office located at '),
                                    WidgetSpan(child: _PlaceholderSpan('[Address]')),
                                    const TextSpan(text: ' (the "Employer"), and '),
                                    WidgetSpan(child: _PlaceholderSpan('[Employee Name]')),
                                    const TextSpan(text: ', an individual residing at '),
                                    WidgetSpan(child: _PlaceholderSpan('[Address]')),
                                    const TextSpan(text: ' (the "Employee").'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              _SectionTitle('1. Appointment and Term', textColor),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  children: [
                                    const TextSpan(text: 'The Employer hereby employs the Employee, and the Employee hereby accepts employment with the Employer, upon the terms and conditions set forth in this Agreement. The term of this Agreement shall commence on '),
                                    WidgetSpan(child: _PlaceholderSpan('[Start Date]')),
                                    const TextSpan(text: ' and shall continue until terminated as provided herein, subject to the provisions of the Labour Act, 2003 (Act 651) '),
                                    WidgetSpan(child: _CitationSpan('ACT 651')),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              _SectionTitle('2. Duties and Responsibilities', textColor),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  children: [
                                    const TextSpan(text: 'The Employee shall serve in the capacity of '),
                                    WidgetSpan(child: _PlaceholderSpan('[Job Title]')),
                                    const TextSpan(text: '. The Employee shall perform such duties and responsibilities as are customarily performed by persons in similar positions and as may be assigned from time to time by the Employer. The Employee agrees to devote their full business time, attention, and best efforts to the performance of their duties.'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              _SectionTitle('3. Compensation', textColor),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '3.1 Salary. ',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                                    ),
                                    const TextSpan(text: 'For all services rendered by the Employee under this Agreement, the Employer shall pay the Employee a base salary of '),
                                    WidgetSpan(child: _PlaceholderSpan('[Amount]')),
                                    const TextSpan(text: ' per month, payable in accordance with the Employer\'s regular payroll practices, subject to statutory deductions including Social Security and National Insurance Trust (SSNIT) contributions '),
                                    WidgetSpan(child: _CitationSpan('SSNIT REF')),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                              
                              // Fade out
                              const SizedBox(height: 24),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      surfaceColor.withValues(alpha: 0),
                                      surfaceColor,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Citation Hint
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info, size: 16, color: secondaryTextColor),
                        const SizedBox(width: 8),
                        Text(
                          'Tap citations to view legal source references',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor.withValues(alpha: 0.95),
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_note),
                    label: const Text('Edit Draft'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      foregroundColor: textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Approve'),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;

  const _SectionTitle(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _PlaceholderSpan extends StatelessWidget {
  final String text;

  const _PlaceholderSpan(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CitationSpan extends StatelessWidget {
  final String text;

  const _CitationSpan(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
