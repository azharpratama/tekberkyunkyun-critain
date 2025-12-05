import 'package:flutter/material.dart';
import '../../../models/user_story.dart';
import '../../../services/story_service.dart';
import '../../../core/theme/app_colors.dart';

class WriteStoryScreen extends StatefulWidget {
  const WriteStoryScreen({super.key});

  @override
  State<WriteStoryScreen> createState() => _WriteStoryScreenState();
}

class _WriteStoryScreenState extends State<WriteStoryScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _storyService = StoryService();

  String _selectedCategory = 'Personal Story';
  bool _isPublishing = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

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
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _publishStory() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isPublishing = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    final newStory = UserStory(
      id: _storyService.generateStoryId(),
      title: _titleController.text.trim(),
      excerpt: _storyService.createExcerpt(_contentController.text.trim()),
      content: _contentController.text.trim(),
      authorName: 'You',
      authorAvatar: 'assets/avatars/default.png',
      date: _formatDate(DateTime.now()),
      category: _selectedCategory,
      readTime: _storyService.calculateReadTime(_contentController.text.trim()),
      likesCount: 0,
      commentsCount: 0,
    );

    _storyService.addStory(newStory);

    if (mounted) {
      setState(() {
        _isPublishing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('✨ Cerita berhasil dipublikasikan!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context, true);
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final contentLength = _contentController.text.length;
    final progress = (contentLength / 50).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.close_rounded, color: Colors.grey[700], size: 20),
          ),
          onPressed: () {
            if (_titleController.text.isNotEmpty ||
                _contentController.text.isNotEmpty) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.warning_rounded,
                            color: Colors.orange[700]),
                      ),
                      const SizedBox(width: 12),
                      const Text('Buang draft?'),
                    ],
                  ),
                  content: const Text(
                    'Cerita yang belum dipublikasikan akan hilang.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        'Batal',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Buang'),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Tulis Cerita',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _isPublishing
                ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  )
                : ElevatedButton.icon(
                    onPressed: _publishStory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.publish_rounded, size: 18),
                    label: const Text(
                      'Publikasikan',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            physics: const BouncingScrollPhysics(),
            children: [
              // Category Selection with premium design
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[50]!,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppColors.primary),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      items: _categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(category),
                            ],
                          ),
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
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Title Field with focus effect
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.3,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'Judul cerita yang menarik...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w700,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12, top: 4),
                    child: Icon(
                      Icons.title_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '📝 Judul tidak boleh kosong';
                  }
                  if (value.trim().length < 5) {
                    return '✏️ Judul minimal 5 karakter';
                  }
                  return null;
                },
              ),

              Container(
                height: 2,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.primary.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Content Field
              TextFormField(
                controller: _contentController,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.8,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText:
                      'Ceritakan pengalaman, pemikiran, atau inspirasi kamu di sini...\n\nTulis dengan jujur dan autentik. Ceritamu mungkin bisa menginspirasi orang lain! ✨',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    height: 1.6,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: null,
                minLines: 12,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  setState(() {});
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
                      AppColors.primary.withOpacity(0.05),
                      AppColors.accentBlue.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: contentLength >= 50
                        ? AppColors.primary.withOpacity(0.3)
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
                              contentLength >= 50
                                  ? Icons.check_circle_rounded
                                  : Icons.edit_rounded,
                              size: 18,
                              color: contentLength >= 50
                                  ? Colors.green
                                  : Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              contentLength >= 50
                                  ? 'Siap dipublikasikan!'
                                  : 'Terus menulis...',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: contentLength >= 50
                                    ? Colors.green
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$contentLength karakter',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: contentLength >= 50
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
                          contentLength >= 50
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
                      AppColors.primary.withOpacity(0.08),
                      AppColors.accentBlue.withOpacity(0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.2),
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
                            gradient: LinearGradient(
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
              color: color.withOpacity(0.15),
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
