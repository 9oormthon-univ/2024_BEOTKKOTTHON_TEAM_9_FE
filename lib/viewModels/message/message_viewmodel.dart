import 'package:bommeong/models/message/message_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:bommeong/services/chat_service.dart';
import 'package:uuid/uuid.dart';

class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;
  RxMap<int, List<ChatMessage>> dogMessages = <int, List<ChatMessage>>{}.obs;
  var isLoading = false.obs;
  var typingUsers = <types.User>[].obs;
  final user = types.User(id: const Uuid().v4());

  @override
  void onInit() {
    super.onInit();
  }

  void clearChatMessages() {
    if (dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value]?.clear();
    }
  }

  List<types.Message> get chatMessages =>
      dogMessages[dogId.value]?.reversed.map((m) => m.toChatMessage()).toList() ?? [];

  void sendMessage(String text) {
    final userMessage = ChatMessage.fromUserInput(text, user.id);
    if (!dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value] = [];
    }
    dogMessages[dogId.value]?.add(userMessage);
    fetchReplyFromDummyAPI(text);
  }

  void fetchReplyFromDummyAPI(String text) async {
    isLoading.value = true;
    GetGPTChat apiService = GetGPTChat();
    String response = await apiService.fetchItems(text);
    final aiMessage = ChatMessage.fromOpenAIResponse(response, 'dog');
    if (!dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value] = [];
    }
    dogMessages[dogId.value]?.add(aiMessage);
    isLoading.value = false;
  }

  Future<void> setId(int id) async {
    print("아이디는 : $id");
    dogId.value = id;
    if (!dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value] = [];
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}

