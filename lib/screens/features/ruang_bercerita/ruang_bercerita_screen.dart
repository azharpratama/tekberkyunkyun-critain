import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/ruang_bercerita_viewmodel.dart';
import '../../../widgets/ruang_bercerita/intro_views.dart';
import '../../../widgets/ruang_bercerita/loading_views.dart';
import '../../../widgets/ruang_bercerita/chat_views.dart';
import '../../../../models/user_stats.dart';

class RuangBerceritaScreen extends StatefulWidget {
  const RuangBerceritaScreen({super.key});

  @override
  State<RuangBerceritaScreen> createState() => _RuangBerceritaScreenState();
}

class _RuangBerceritaScreenState extends State<RuangBerceritaScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RuangBerceritaViewModel(),
      child: const _RuangBerceritaContent(),
    );
  }
}

class _RuangBerceritaContent extends StatefulWidget {
  const _RuangBerceritaContent();

  @override
  State<_RuangBerceritaContent> createState() => _RuangBerceritaContentState();
}

class _RuangBerceritaContentState extends State<_RuangBerceritaContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RuangBerceritaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<RuangBerceritaViewModel>(context, listen: false);
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Update mode in ViewModel when tab changes
        _viewModel.setMode(_tabController.index == 0);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<RuangBerceritaViewModel>(
        builder: (context, vm, child) {
          // Listen for errors
          if (vm.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(vm.errorMessage!)),
              );
            });
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: vm.isInSession
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => _showEndSessionDialog(context, vm),
                    )
                  : (Navigator.canPop(context)
                      ? IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        )
                      : null),
              automaticallyImplyLeading: false,
              title: const Text(
                'Ruang Bercerita',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              bottom: vm.isInSession
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          // Bubble Style Properties
                          indicator: BoxDecoration(
                            color: const Color(0xFF3A9D76),
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
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          dividerColor: Colors.transparent,
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          padding: const EdgeInsets.all(4),
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.mic, size: 18),
                                  SizedBox(width: 8),
                                  Text('Bercerita'),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.hearing, size: 18),
                                  SizedBox(width: 8),
                                  Text('Jadi Pendengar'),
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
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _SpeakerMode(),
                _ListenerMode(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SpeakerMode extends StatelessWidget {
  const _SpeakerMode();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RuangBerceritaViewModel>();

    if (vm.currentStep == 0) {
      return IntroView(onStart: vm.startSession);
    }
    if (vm.currentStep == 1) {
      return const SearchingView();
    }
    return ChatView(
      onEnd: () {
        // Trigger the end session dialog from the parent page
        // Since the dialog logic is in the parent, we can find the parent state
        // OR better, we can just call a callback if we passed one.
        // But here, we can access the parent widget's method if we made it public or static?
        // Actually, the ChatView's onEnd usually triggers the dialog.
        // Let's use the same dialog logic.
        // Ideally, the ViewModel should handle the dialog request or we duplicate the dialog call here.
        // For simplicity, let's duplicate the dialog call or make a static helper.
        // Or better: The ChatView just calls vm.endSession() directly?
        // No, we want the confirmation dialog.

        // Let's find the ancestor state or just re-implement the dialog show here.
        // Since we are inside the same file, we can extract the dialog function to a standalone function.
        _showEndSessionDialog(context, vm);
      },
    );
  }
}

class _ListenerMode extends StatelessWidget {
  const _ListenerMode();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RuangBerceritaViewModel>();

    if (vm.currentStep == 0) {
      return ListenerIntroView(onStart: vm.startSession);
    }
    if (vm.currentStep == 1) {
      return const WaitingView();
    }
    return ChatView(
      onEnd: () => _showEndSessionDialog(context, vm),
    );
  }
}

// Helper function to show dialog (duplicated for now to avoid complex passing)
void _showEndSessionDialog(BuildContext context, RuangBerceritaViewModel vm) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Akhiri Sesi?'),
      content: const Text('Apakah Anda yakin ingin mengakhiri sesi ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            vm.endSession();
            _showRewardDialog(context, vm);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Akhiri'),
        ),
      ],
    ),
  );
}

void _showRewardDialog(BuildContext context, RuangBerceritaViewModel vm) {
  final stats = UserStatsService.currentStats;
  final isSpeaker = vm.isSpeakerMode;
  final points = vm.rewardPoints;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Text('🎉'),
          SizedBox(width: 8),
          Text('Terima Kasih!'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '+$points Poin',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (isSpeaker)
            const Text(
              'Semoga kamu merasa lebih baik! 💚',
              textAlign: TextAlign.center,
            )
          else ...[
            Text(
              '📊 Progres Badge ${stats.getBadgeEmoji()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: stats.getBadgeProgress(),
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Color(0xFF3A9D76)),
            ),
            const SizedBox(height: 8),
            Text(
              '${stats.listeningSessionsCompleted}/${stats.getSessionsForNextBadge()} → ${stats.getNextBadgeLevel()}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    '💚 Kamu sudah membantu',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stats.peopleHelped} orang',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A9D76),
                    ),
                  ),
                  const Text(
                    'merasa didengar',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A9D76),
            minimumSize: const Size(double.infinity, 45),
          ),
          child: const Text('Lanjut'),
        ),
      ],
    ),
  );
}
