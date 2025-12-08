import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../services/perpustakaan_cerita_service.dart';
import '../../../core/theme/app_colors.dart';

import '../../../models/user_story.dart';

class WriteStoryScreen extends StatefulWidget {
  final UserStory? story;

  const WriteStoryScreen({super.key, this.story});

  @override
  State<WriteStoryScreen> createState() => _WriteStoryScreenState();
}

class _WriteStoryScreenState extends State<WriteStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final _service = PerpustakaanCeritaService();

  String _selectedCategory = 'Personal Story';
  bool _isPublishing = false;
  int _contentLength = 0;

  bool get _isEditing => widget.story != null;

  final List<String> _categories = [
    'Personal Story',
    'Kesehatan Mental',
    'Wellness',
    'Work',
    'Relationships',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.story?.title);
    _contentController = TextEditingController(text: widget.story?.content);
    _contentLength = _contentController.text.length;

    // Ensure selected category is valid
    if (widget.story != null && _categories.contains(widget.story!.category)) {
      _selectedCategory = widget.story!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String calculateReadTime(String content) {
    final wordCount = content.split(RegExp(r'\s+')).length;
    final minutes = (wordCount / 200).ceil();
    return '$minutes min read';
  }

  void _publishStory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    try {
      if (_isEditing) {
        await _service.updateStory(
          storyId: widget.story!.id,
          title: _titleController.text.trim(),
          excerpt: _contentController.text.trim().length > 150
              ? '${_contentController.text.trim().substring(0, 150)}...'
              : _contentController.text.trim(),
          content: _contentController.text.trim(),
          category: _selectedCategory,
          readTime: calculateReadTime(_contentController.text.trim()),
        );
      } else {
        await _service.createStory(
          title: _titleController.text.trim(),
          excerpt: _contentController.text.trim().length > 150
              ? '${_contentController.text.trim().substring(0, 150)}...'
              : _contentController.text.trim(),
          content: _contentController.text.trim(),
          category: _selectedCategory,
          readTime: calculateReadTime(_contentController.text.trim()),
        );
      }

      if (mounted) {
        setState(() {
          _isPublishing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(_isEditing
                    ? '✨ Cerita berhasil diperbarui!'
                    : '✨ Cerita berhasil dipublikasikan!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isPublishing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_contentLength / 50).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Cerita' : 'Tulis Cerita',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Judul Cerita',
                  hintText: 'Berikan judul yang menarik...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.title_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Category Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.category_rounded),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Content Field
              TextFormField(
                controller: _contentController,
                maxLines: null,
                minLines: 12,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 16, height: 1.5),
                decoration: InputDecoration(
                  labelText: 'Isi Cerita',
                  hintText: 'Tuliskan ceritamu di sini...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(20),
                ),
                onChanged: (value) {
                  setState(() {
                    _contentLength = value.trim().length;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '📖 Konten cerita tidak boleh kosong';
                  }
                  if (value.trim().length < 50) {
                    return '📝 Cerita minimal 50 karakter (${value.trim().length}/50)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Character Counter with Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.05),
                      AppColors.accentBlue.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _contentLength >= 50
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _contentLength >= 50
                                  ? Icons.check_circle_rounded
                                  : Icons.edit_rounded,
                              size: 18,
                              color: _contentLength >= 50
                                  ? Colors.green
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _contentLength >= 50
                                  ? 'Siap dipublikasikan!'
                                  : 'Terus menulis...',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _contentLength >= 50
                                    ? Colors.green
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$_contentLength karakter',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _contentLength >= 50
                                ? AppColors.primary
                                : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _contentLength >= 50
                              ? Colors.green
                              : AppColors.primary,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Tips Card with enhanced design
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.08),
                      AppColors.accentBlue.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.accentBlue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.lightbulb_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Tips Menulis',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTip(
                      icon: Icons.favorite_rounded,
                      text: 'Tulis dengan jujur dan autentik',
                      color: Colors.red[400]!,
                    ),
                    _buildTip(
                      icon: Icons.school_rounded,
                      text: 'Bagikan pembelajaran dari pengalamanmu',
                      color: Colors.blue[400]!,
                    ),
                    _buildTip(
                      icon: Icons.privacy_tip_rounded,
                      text: 'Hormati privasi orang lain',
                      color: Colors.orange[400]!,
                    ),
                    _buildTip(
                      icon: Icons.thumb_up_rounded,
                      text: 'Gunakan bahasa yang sopan dan positif',
                      color: Colors.green[400]!,
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Publish Button
              ElevatedButton(
                onPressed: _isPublishing ? null : _publishStory,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.primary.withValues(alpha: 0.4),
                ),
                child: _isPublishing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.send_rounded),
                          const SizedBox(width: 8),
                          Text(
                            _isEditing
                                ? 'Simpan Perubahan'
                                : 'Publikasikan Cerita',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTip({
    required IconData icon,
    required String text,
    required Color color,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
