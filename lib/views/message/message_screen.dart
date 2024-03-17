import 'package:bommeong/utilities/font_system.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class MessageScreen extends BaseScreen<ChatViewModel> {
  const MessageScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final messageViewModel = Get.find<MessageViewModel>();
    final types.User user = types.User(id: const Uuid().v4());
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(
            "assets/images/home/goBack.svg",
            height: 40,
            color: Colors.black,
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Obx(() {
                // Chat 위젯을 사용하여 메시지 목록과 입력 필드를 표시합니다.
                return Chat(
                  messages: messageViewModel.chatMessages,
                  onSendPressed: (partialText) {
                    // 메시지 전송 로직
                    messageViewModel.sendMessage(partialText.text, user.id);
                  },
                  user: user,
                );
              }),
            ),
          ],
        ),
      ],
    );



  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}
