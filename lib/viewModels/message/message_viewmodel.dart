import 'package:bommeong/models/message/message_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:bommeong/services/chat_service.dart';

class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void clearChatMessages() {
    messages.clear();
  }

  List<types.Message> get chatMessages => messages.reversed.map((m) => m.toChatMessage()).toList();


  void sendMessage(String text, String userId) {
    final userMessage = ChatMessage.fromUserInput(text, userId);
    messages.add(userMessage);
    fetchReplyFromDummyAPI(text, userId);
  }

  void fetchReplyFromDummyAPI(String text, String userId) async {
    // 실제 HTTP 요청으로 대체
    GetGPTChat apiService = GetGPTChat();
    String response = await apiService.fetchItems(text);
    final aiMessage = ChatMessage.fromOpenAIResponse(response, '5');
    messages.add(aiMessage);
  }



Future<void> setId(int id) async{
    print("아이디는 : ${id}");
    this.dogId.value = id;
  }

  @override
  void onClose() {
    super.onClose();
  }
}