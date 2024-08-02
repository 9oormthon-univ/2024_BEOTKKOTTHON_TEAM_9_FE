import 'package:bommeong/models/message/message_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:bommeong/services/chat_service.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:uuid/uuid.dart';

class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;
  RxMap<int, List<ChatMessage>> dogMessages = <int, List<ChatMessage>>{}.obs;
  var isLoading = false.obs;
  var typingUsers = <types.User>[].obs;
  RxBool isRandomChat = false.obs;
  final user = types.User(id: const Uuid().v4());
  RxInt chatMessages_length = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(dogMessages, (_) => updateChatLength());
  }

  void clearChatMessages() {
    if (dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value]?.clear();
      updateChatLength();
    }
  }

  Future<void> RandomChat() async {
    isRandomChat.value = false;
  }

  Future<void> TrueChat() async {
    isRandomChat.value = true;
  }

  void updateChatLength() async {
    chatMessages_length.value = chatMessages.length;
    print("채팅 길이 업데이트");
    print(chatMessages_length.value);
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


    updateChatLength();
    isLoading.value = false;
  }

  Future<void> setId(int id) async {
    print("아이디는 : $id");
    dogId.value = id;
    if (!dogMessages.containsKey(dogId.value)) {
      dogMessages[dogId.value] = [];
    }
    updateChatLength();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

