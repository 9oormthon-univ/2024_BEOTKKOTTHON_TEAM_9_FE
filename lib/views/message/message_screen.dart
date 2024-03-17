import 'package:bommeong/utilities/font_system.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageScreen extends BaseScreen<ChatViewModel> {
  const MessageScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final messageViewModel = Get.find<MessageViewModel>();
    return Stack(
      children: [InkWell(
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
              child: Obx(() => ListView.builder(
                itemCount: messageViewModel.messages.length,
                itemBuilder: (context, index) {
                  var message = messageViewModel.messages[index].message;
                  String messageText = '';

                  // 메시지 타입이 TextMessage인 경우에만 텍스트 추출
                  if (message is types.TextMessage) {
                    messageText = message.text;
                  }

                  // ListTile 또는 다른 위젯을 사용하여 메시지 표시
                  return ListTile(
                    title: Text(messageText),
                  );
                },
              ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  // 사용자가 메시지를 입력하고 전송 버튼을 누를 때의 로직을 여기에 추가합니다.
                  messageViewModel.sendMessage(value, "user-id"); // 사용자 ID는 적절하게 설정해야 합니다.
                },
                decoration: InputDecoration(
                  labelText: '메시지 입력...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ]
    );

  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}
