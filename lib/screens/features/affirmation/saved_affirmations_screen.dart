import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/ruang_afirmasi_service.dart';

class SavedAffirmationsScreen extends StatefulWidget {
  const SavedAffirmationsScreen({super.key});

  @override
  State<SavedAffirmationsScreen> createState() =>
      _SavedAffirmationsScreenState();
}

class _SavedAffirmationsScreenState extends State<SavedAffirmationsScreen> {
  final _afirmasiService = RuangAfirmasiService();
  List<Map<String, dynamic>> _savedAffirmations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAffirmations();
  }

  Future<void> _loadSavedAffirmations() async {
    setState(() => _isLoading = true);

    try {
      final data = await _afirmasiService.getSavedRuangAffirmasi();
      setState(() {
        _savedAffirmations = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat afirmasi: $e')),
        );
      }
    }
  }

  Future<void> _removeAffirmation(String affirmationId) async {
    try {
      await _afirmasiService.unsaveAffirmation(affirmationId);
      await _loadSavedAffirmations(); // Reload list
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Afirmasi dihapus dari koleksi')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Koleksi Afirmasi',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedAffirmations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada afirmasi tersimpan',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Simpan pesan positif yang kamu suka!',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _savedAffirmations.length,
                  itemBuilder: (context, index) {
                    final item = _savedAffirmations[index];
                    final affirmation =
                        item['ruang_afirmasi'] as Map<String, dynamic>;
                    final affirmationId = item['affirmation_id'] as String;
                    final text = affirmation['content'] as String;

                    // Generate a random color for variety
                    final color = _getColorForIndex(index);

                    return Dismissible(
                      key: Key(affirmationId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.delete, color: Colors.red),
                      ),
                      onDismissed: (direction) {
                        _removeAffirmation(affirmationId);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              _showOptions(context, text, affirmationId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  void _showOptions(BuildContext context, String text, String affirmationId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Salin Teks'),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: text));
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Teks disalin! 📋')),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Hapus dari Koleksi',
                  style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await _removeAffirmation(affirmationId);
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [
      const Color(0xFFFFCDD2), // Pink
      const Color(0xFFFFE0B2), // Orange
      const Color(0xFFB3E5FC), // Blue
      const Color(0xFFC8E6C9), // Green
      const Color(0xFFE1BEE7), // Purple
      const Color(0xFFF0F4C3), // Yellow
      const Color(0xFFB2DFDB), // Teal
      const Color(0xFFFFCCBC), // Deep Orange
    ];
    return colors[index % colors.length];
  }
}
