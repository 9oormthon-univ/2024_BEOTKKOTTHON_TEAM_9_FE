import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessage {
  final types.Message message;

  ChatMessage({required this.message});

  factory ChatMessage.fromOpenAIResponse(String text, String userId) {
    return ChatMessage(
      message: types.TextMessage(
        author: types.User(id: userId),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(),
        text: text,
      ),
    );
  }

  factory ChatMessage.fromUserInput(String text, String userId) {
    return ChatMessage(
      message: types.TextMessage(
        author: types.User(id: userId),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toString(),
        text: text,
      ),
    );
  }

  types.Message toChatMessage() {
    return message;
  }
}

