import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arbibot/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arbibot/features/common/repositories/database_repository.dart';
import 'package:arbibot/features/auth/repositories/auth_repository.dart';

class DocumentsLibraryScreen extends ConsumerStatefulWidget {
  const DocumentsLibraryScreen({super.key});

  @override
  ConsumerState<DocumentsLibraryScreen> createState() => _DocumentsLibraryScreenState();
}

class _DocumentsLibraryScreenState extends ConsumerState<DocumentsLibraryScreen> {
  List<Map<String, dynamic>> _documents = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';
  String _searchQuery = '';

  final List<Map<String, String>> _filters = [
    {'key': 'all', 'label': 'All'},
    {'key': 'contract', 'label': 'Contracts'},
    {'key': 'motion', 'label': 'Motions'},
    {'key': 'brief', 'label': 'Briefs'},
    {'key': 'other', 'label': 'Other'},
  ];

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    setState(() => _isLoading = true);
    try {
      final userId = ref.read(authRepositoryProvider).currentUser?.id;
      if (userId != null) {
        final docs = await ref.read(databaseRepositoryProvider).getDocuments(userId);
        if (mounted) {
          setState(() {
            _documents = docs;
            _isLoading = false;
          });
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading documents: $e')),
        );
      }
    }
  }

  Future<void> _deleteDocument(String docId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: const Text('Are you sure you want to delete this document?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(databaseRepositoryProvider).deleteDocument(docId);
        _loadDocuments();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting document: $e')),
          );
        }
      }
    }
  }

  List<Map<String, dynamic>> get _filteredDocuments {
    var docs = _documents;
    
    if (_selectedFilter != 'all') {
      docs = docs.where((doc) => doc['document_type'] == _selectedFilter).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      docs = docs.where((doc) {
        final title = (doc['title'] ?? '').toString().toLowerCase();
        return title.contains(_searchQuery.toLowerCase());
      }).toList();
    }
    
    return docs;
  }

  String _formatDate(String? timestamp) {
    if (timestamp == null) return '';
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return '';
    }
  }

  IconData _getDocTypeIcon(String? type) {
    switch (type) {
      case 'contract':
        return Icons.description;
      case 'motion':
        return Icons.gavel;
      case 'brief':
        return Icons.article;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getDocTypeColor(String? type) {
    switch (type) {
      case 'contract':
        return Colors.blue;
      case 'motion':
        return Colors.purple;
      case 'brief':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
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
                        onPressed: _loadDocuments,
                        icon: Icon(Icons.refresh, color: secondaryTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search documents...',
                      prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                      filled: true,
                      fillColor: isDark ? surfaceColor : Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter['key'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter['label']!),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter['key']!);
                      },
                      backgroundColor: surfaceColor,
                      selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.primaryColor : secondaryTextColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Documents List
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredDocuments.isEmpty
                      ? _buildEmptyState(textColor, secondaryTextColor)
                      : RefreshIndicator(
                          onRefresh: _loadDocuments,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredDocuments.length,
                            itemBuilder: (context, index) {
                              final doc = _filteredDocuments[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _DocumentItem(
                                  title: doc['title'] ?? 'Untitled',
                                  type: doc['document_type'] ?? 'other',
                                  date: _formatDate(doc['created_at']),
                                  icon: _getDocTypeIcon(doc['document_type']),
                                  color: _getDocTypeColor(doc['document_type']),
                                  onTap: () => context.push('/document/${doc['id']}'),
                                  onDelete: () => _deleteDocument(doc['id']),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/draft/new'),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(Color textColor, Color secondaryTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: secondaryTextColor),
          const SizedBox(height: 16),
          Text(
            'No documents yet',
            style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new document to get started',
            style: TextStyle(color: secondaryTextColor),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.push('/draft/new'),
            icon: const Icon(Icons.add),
            label: const Text('New Document'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title;
  final String type;
  final String date;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _DocumentItem({
    required this.title,
    required this.type,
    required this.date,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF111418);
    final secondaryTextColor = isDark ? const Color(0xFF9DABB9) : const Color(0xFF637588);
    final surfaceColor = isDark ? const Color(0xFF1C252E) : Colors.white;

    return Dismissible(
      key: Key(title + date),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF283039) : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            type.toUpperCase(),
                            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          date,
                          style: TextStyle(color: secondaryTextColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: secondaryTextColor),
            ],
          ),
        ),
      ),
    );
  }
}
