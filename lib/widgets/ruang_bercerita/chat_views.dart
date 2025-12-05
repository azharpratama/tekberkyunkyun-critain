import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/ruang_bercerita_viewmodel.dart';
import '../../core/theme/app_colors.dart';
import '../animations/typing_indicator.dart';
import '../common/custom_text_field.dart';

class ChatView extends StatefulWidget {
  final VoidCallback onEnd;

  const ChatView({super.key, required this.onEnd});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(RuangBerceritaViewModel vm) {
    if (_messageController.text.trim().isEmpty) return;
    vm.sendMessage(_messageController.text);
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RuangBerceritaViewModel>(
      builder: (context, vm, child) {
        // Auto-scroll when messages change or typing status changes
        // Note: This might trigger too often, but for now it ensures visibility
        if (vm.messages.isNotEmpty || vm.isPartnerTyping) {
          _scrollToBottom();
        }

        final partnerName =
            vm.isSpeakerMode ? 'Pendengar Anonim' : 'Pencerita Anonim';
        final partnerColor =
            vm.isSpeakerMode ? const Color(0xFF3A9D76) : AppColors.accentOrange;

        return Column(
          children: [
            // Chat Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  CircleAvatar(
                    backgroundColor: partnerColor.withValues(alpha: 0.2),
                    child: Icon(Icons.person, color: partnerColor),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        partnerName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Online',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app, color: Colors.red),
                    onPressed: widget.onEnd,
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: vm.messages.length + (vm.isPartnerTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == vm.messages.length) {
                    return const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: TypingIndicator(),
                      ),
                    );
                  }

                  final message = vm.messages[index];
                  return _buildMessageBubble(
                    message.text,
                    isUser: message.isUser,
                    bubbleColor: partnerColor,
                  );
                },
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _messageController,
                      hintText: vm.isSpeakerMode
                          ? 'Ketik pesanmu...'
                          : 'Ketik respon supportifmu...',
                      // We can use onSubmitted if we modify CustomTextField,
                      // or just rely on the send button for now as CustomTextField
                      // doesn't expose onSubmitted yet.
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: partnerColor,
                    child: IconButton(
                      icon:
                          const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () => _sendMessage(vm),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessageBubble(String text,
      {required bool isUser, required Color bubbleColor}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isUser ? bubbleColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isUser
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// Removed ListeningChatView as it is now unified into ChatView
