import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../model/chat_message_model.dart';
import '../model/conversation_model.dart';

class MessagingController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController messageInputController = TextEditingController();

  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  final RxList<ConversationModel> filteredConversations =
      <ConversationModel>[].obs;
  final RxBool isLoading = false.obs;

  // Tab State: 0 = Customer, 1 = Support Team
  final RxInt selectedTabIndex = 0.obs;

  // Active Chat State
  final Rx<ConversationModel?> activeConversation = Rx<ConversationModel?>(
    null,
  );
  final RxList<ChatMessageModel> chatMessages = <ChatMessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    super.onClose();
  }

  void _onSearchChanged() {
    filterConversations(searchController.text);
  }

  /// Switch Tab between Customer (0) and Support Team (1)
  void changeTab(int index) {
    if (selectedTabIndex.value == index) return;
    selectedTabIndex.value = index;
    searchController.clear();
    loadConversations();
  }

  /// Load conversations based on active tab
  void loadConversations() {
    isLoading.value = true;

    if (selectedTabIndex.value == 0) {
      // Customer Conversations Mock Data
      conversations.value = [
        ConversationModel(
          id: '1',
          userName: 'Wade Warren',
          userAvatar:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=300',
          lastMessage: 'It is a long established fact that...',
          time: '4:30 PM',
          unreadCount: 0,
        ),
        ConversationModel(
          id: '2',
          userName: 'Luca Romano',
          userAvatar:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=300',
          lastMessage: 'It is a long established fact',
          time: '8:00 AM',
          unreadCount: 3,
        ),
        ConversationModel(
          id: '3',
          userName: 'David Smith',
          userAvatar:
              'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&q=80&w=300',
          lastMessage: 'It is a long established fact that...',
          time: '10:30 PM',
          unreadCount: 0,
        ),
        ConversationModel(
          id: '4',
          userName: 'Carlos Gomez',
          userAvatar:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=300',
          lastMessage: 'It is a long established fact',
          time: '12:00 PM',
          unreadCount: 4,
        ),
      ];
    } else {
      // Support Team Mock Data
      conversations.value = [
        ConversationModel(
          id: 's1',
          userName: 'Support',
          userAvatar:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=300',
          lastMessage: 'It is a long established fact that...',
          time: '4:30 PM',
          unreadCount: 0,
        ),
      ];
    }

    filteredConversations.value = conversations;
    isLoading.value = false;
  }

  /// Search filtering logic
  void filterConversations(String query) {
    if (query.isEmpty) {
      filteredConversations.value = conversations;
    } else {
      filteredConversations.value = conversations
          .where(
            (item) =>
                item.userName.toLowerCase().contains(query.toLowerCase()) ||
                item.lastMessage.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  /// Select & Open Active Chat
  void onConversationTap(ConversationModel conversation) {
    activeConversation.value = conversation;
    loadChatMessages(conversation.id);
    Get.toNamed(AppRoutes.chat);
  }

  /// Populate dummy messages for active chat
  void loadChatMessages(String conversationId) {
    chatMessages.value = [
      ChatMessageModel(
        id: 'm1',
        message: 'Hi there! How can I help you with your pet today?',
        time: '10:00 AM',
        isMe: false,
      ),
      ChatMessageModel(
        id: 'm2',
        message: 'I want to schedule a grooming session for Tonny.',
        time: '10:02 AM',
        isMe: true,
      ),
      ChatMessageModel(
        id: 'm3',
        message: 'Sure! Is tomorrow at 2:00 PM fine for you?',
        time: '10:05 AM',
        isMe: false,
      ),
    ];
  }

  /// Send New Message
  void sendMessage() {
    final String text = messageInputController.text.trim();
    if (text.isEmpty) return;

    chatMessages.add(
      ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: text,
        time: 'Just now',
        isMe: true,
      ),
    );

    messageInputController.clear();
  }
}
