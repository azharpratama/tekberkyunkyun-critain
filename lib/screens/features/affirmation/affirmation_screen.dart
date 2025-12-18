import 'dart:math';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../viewmodels/affirmation_viewmodel.dart';
import '../../../../widgets/ruang_afirmasi/affirmation_card.dart';
import '../../../../widgets/common/custom_text_field.dart';
import '../../../../widgets/common/primary_button.dart';
import '../../../../widgets/buttons/animated_heart_button.dart';

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AffirmationViewModel(),
      child: const _AffirmationContent(),
    );
  }
}

class _AffirmationContent extends StatefulWidget {
  const _AffirmationContent();

  @override
  State<_AffirmationContent> createState() => _AffirmationContentState();
}

class _AffirmationContentState extends State<_AffirmationContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (Navigator.canPop(context)
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context),
              )
            : null),
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.ruangAfirmasiTitle,
          style: AppTextStyles.h2,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.accentRed,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.all(4),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, size: 18),
                      SizedBox(width: 8),
                      Text(AppStrings.tabReceive),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send, size: 18),
                      SizedBox(width: 8),
                      Text(AppStrings.tabSend),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ReceiveAffirmationTab(),
          _SendAffirmationTab(),
        ],
      ),
    );
  }
}

class _ReceiveAffirmationTab extends StatefulWidget {
  const _ReceiveAffirmationTab();

  @override
  State<_ReceiveAffirmationTab> createState() => _ReceiveAffirmationTabState();
}

class _ReceiveAffirmationTabState extends State<_ReceiveAffirmationTab> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AffirmationViewModel>();

    return Column(
      children: [
        const SizedBox(height: AppDimens.p24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p24),
          child: Text(
            AppStrings.receiveHint,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: AppDimens.p24),
        Expanded(
          child: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : vm.affirmations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sentiment_dissatisfied,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada afirmasi tersedia',
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) => vm.setAffirmationIndex(index),
                      itemCount: 10000,
                      itemBuilder: (context, index) {
                        final actualIndex = index % vm.affirmations.length;
                        final affirmation = vm.affirmations[actualIndex];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.p32,
                              vertical: AppDimens.p16),
                          child: AffirmationCard(
                            text: affirmation.text,
                            backgroundColor: affirmation.color,
                            textColor: Colors.black87,
                          ),
                        );
                      },
                    ),
        ),
        const SizedBox(height: AppDimens.p24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.p12, horizontal: AppDimens.p24),
                child: Column(
                  children: [
                    AnimatedHeartButton(
                      isSaved: vm.isCurrentAffirmationSaved(),
                      transparent: true,
                      onTap: () async {
                        await vm.toggleSaveCurrentAffirmation();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                vm.isCurrentAffirmationSaved()
                                    ? AppStrings.affirmationSaved
                                    : AppStrings.affirmationRemoved,
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: AppDimens.p8),
                    Text(
                      AppStrings.save,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: vm.isCurrentAffirmationSaved()
                            ? AppColors.accentRed
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _ActionButton(
                icon: Icons.share_outlined,
                label: AppStrings.share,
                onTap: () async {
                  final text = vm.currentAffirmation?.text;
                  if (text != null) {
                    // ignore: deprecated_member_use
                    await Share.share(text);
                  }
                },
              ),
              _ActionButton(
                icon: Icons.refresh,
                label: AppStrings.shuffle,
                onTap: () {
                  final random = Random();
                  final newIndex = random.nextInt(vm.affirmations.length);
                  final currentPage = _pageController.page?.round() ?? 0;
                  final currentCycle = currentPage ~/ vm.affirmations.length;
                  final targetPage =
                      (currentCycle * vm.affirmations.length) + newIndex;

                  final finalPage = targetPage <= currentPage
                      ? targetPage + vm.affirmations.length
                      : targetPage;

                  _pageController.animateToPage(
                    finalPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.p32),
        const SizedBox(height: AppDimens.p32),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.r16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.p12, horizontal: AppDimens.p24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.accentRed, size: 24),
            ),
            const SizedBox(height: AppDimens.p8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendAffirmationTab extends StatefulWidget {
  const _SendAffirmationTab();

  @override
  State<_SendAffirmationTab> createState() => _SendAffirmationTabState();
}

class _SendAffirmationTabState extends State<_SendAffirmationTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      context.read<AffirmationViewModel>().updateMessage(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendAffirmation(AffirmationViewModel vm) async {
    if (!vm.canSend()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.warningEmpty),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Send to database
    final success = await vm.sendAffirmation();

    // Close loading
    if (mounted) Navigator.pop(context);

    // Show result
    if (mounted) {
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.r16)),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 28),
                SizedBox(width: 8),
                Text('Berhasil Terkirim!'),
              ],
            ),
            content: const Text(
                'Afirmasimu telah berhasil dibagikan ke komunitas ❤️'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentRed,
                ),
                child: const Text(AppStrings.close),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengirim afirmasi. Silakan coba lagi.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AffirmationViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.p20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimens.r16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppDimens.p8),
                      decoration: BoxDecoration(
                        color: AppColors.accentRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppDimens.r8),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.accentRed,
                      ),
                    ),
                    const SizedBox(width: AppDimens.p12),
                    Text(
                      AppStrings.writePositiveWords,
                      style: AppTextStyles.h3,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.p16),
                CustomTextField(
                  controller: _controller,
                  hintText: AppStrings.sendHint,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  maxLength: AffirmationViewModel.maxChars,
                ),
                const SizedBox(height: AppDimens.p8),
                Text(
                  '${vm.charCount} / ${AffirmationViewModel.maxChars} karakter',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.p24),
          Text(
            AppStrings.quickTemplate,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: AppDimens.p12),
          Wrap(
            spacing: AppDimens.p8,
            runSpacing: AppDimens.p8,
            children: [
              _TemplateChip(
                label: '💪 Kamu kuat!',
                onTap: () {
                  vm.appendTemplate('Kamu lebih kuat dari yang kamu kira. ');
                  _controller.text = vm.messageText;
                },
              ),
              _TemplateChip(
                label: '🌟 Kamu berharga!',
                onTap: () {
                  vm.appendTemplate('Kamu adalah individu yang berharga. ');
                  _controller.text = vm.messageText;
                },
              ),
              _TemplateChip(
                label: '❤️ Tidak sendirian',
                onTap: () {
                  vm.appendTemplate('Kamu tidak sendirian dalam ini. ');
                  _controller.text = vm.messageText;
                },
              ),
              _TemplateChip(
                label: '✨ Tetap semangat!',
                onTap: () {
                  vm.appendTemplate(
                      'Tetap semangat, hari esok pasti lebih baik! ');
                  _controller.text = vm.messageText;
                },
              ),
            ],
          ),
          const SizedBox(height: AppDimens.p32),
          PrimaryButton(
            text: AppStrings.sendAffirmationButton,
            onPressed: () => _sendAffirmation(vm),
            backgroundColor: AppColors.accentRed,
            width: double.infinity,
            icon: Icons.send,
          ),
          const SizedBox(height: AppDimens.p16),
          Center(
            child: Text(
              AppStrings.anonymousNote,
              style: AppTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _TemplateChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TemplateChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.r20),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.p12, vertical: AppDimens.p8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.r20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(label, style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
