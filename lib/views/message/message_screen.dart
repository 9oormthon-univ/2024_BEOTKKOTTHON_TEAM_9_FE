import 'package:bommeong/services/userpreferences_service.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
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
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (messageViewModel.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('강아지가 대답을 골똘히 생각중이에요..! 🐾',
                        style: FontSystem.KR18B),
                  ],
                ),
              );
            } else {
              return Chat(
                showUserAvatars: true,
                messages: messageViewModel.chatMessages,
                onSendPressed: (partialText) {
                  // 메시지 전송 로직
                  messageViewModel.sendMessage(partialText.text);
                },
                user: messageViewModel.user,
              );
            }
          }),
        ),
      ],
    );
  }

  @override
  buildAppBar(BuildContext context) {
    final messageViewModel = Get.find<MessageViewModel>();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: Get.width,
      leading: Container(
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.03,
            bottom: Get.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("채팅", style: FontSystem.KR20B),
            InkWell(
              onTap: () {
                messageViewModel.clearChatMessages();
                RootViewModel rootViewModel = Get.put(RootViewModel());
                rootViewModel.changeIndex(0);
              },
              child: SvgPicture.asset(
                "assets/icons/back_black.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

