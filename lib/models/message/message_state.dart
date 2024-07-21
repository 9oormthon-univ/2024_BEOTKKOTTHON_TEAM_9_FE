import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';


class ChatMessage {
  final types.Message message;

  ChatMessage({required this.message});

  factory ChatMessage.fromOpenAIResponse(String text, String userId) {
    return ChatMessage(
      message: types.TextMessage(
        author: types.User(id: userId),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(), // 예제로, 실제 사용시 고유 ID 사용
        text: text,
      ),
    );
  }

  factory ChatMessage.fromUserInput(String text, String userId) {
    return ChatMessage(
      message: types.TextMessage(
        author: types.User(id: userId),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(), // 예시로 사용, 실제 앱에서는 고유한 ID 생성 방식을 사용해야.
        text: text,
      ),
    );
  }

  types.Message toChatMessage() {
    return message;
  }

}
