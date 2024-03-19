import 'package:bommeong/models/message/message_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
  }


  List<types.Message> get chatMessages => messages.reversed.map((m) => m.toChatMessage()).toList();


  void sendMessage(String text, String userId) {
    final userMessage = ChatMessage.fromUserInput(text, userId);
    messages.add(userMessage);
    // OpenAI 또는 다른 API로부터의 응답을 시뮬레이션
    fetchReplyFromDummyAPI(text, userId);
  }

  void fetchReplyFromDummyAPI(String text, String userId) async {
    // 실제 HTTP 요청으로 대체
    await Future.delayed(Duration(seconds: 1));
    final response = "안녕하세요, 저는 더미 AI입니다. '$text'라고 말씀하셨군요!";
    final aiMessage = ChatMessage.fromOpenAIResponse(response, 'ai');
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