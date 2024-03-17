import 'package:bommeong/models/message/message_state.dart';
import 'package:get/get.dart';


class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;
  var messages = <ChatMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void sendMessage(String text, String userId) {
    // 사용자 메시지 처리
    final userMessage = ChatMessage.fromUserInput(text, userId);
    messages.add(userMessage);
    update();
    // 더미 API 호출을 시뮬레이션
    fetchReplyFromDummyAPI(text, userId);
  }

  void fetchReplyFromDummyAPI(String text, String userId) async {
    // 실제 HTTP 요청으로 대체
    await Future.delayed(Duration(seconds: 1));

    // 더미 응답. 실제로는 서버로부터의 응답 데이터
    final response = "안녕하세요, 저는 더미 AI입니다. '$text'라고 말씀하셨군요!";

    // 응답을 받아 ChatMessage로
    final aiMessage = ChatMessage.fromOpenAIResponse(response, userId);
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