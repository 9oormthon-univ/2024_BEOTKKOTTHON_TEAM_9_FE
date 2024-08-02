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
import '../privacy/privacy_consent_screen.dart';

class MessageScreen extends BaseScreen<ChatViewModel> {
  MessageScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final MessageViewModel messageViewModel = Get.find<MessageViewModel>();

    return Column(
      children: [
        Obx(() {
          if (messageViewModel.chatMessages_length >= 6 && messageViewModel.isRandomChat.value) {
            return const _TopButton();
          } else {
            return const SizedBox.shrink(); // 빈 공간 반환
          }
        }),
        Expanded(
          child: Obx(() {
            if (messageViewModel.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('강아지가 대답을 골똘히 생각중이에요..! 🐾', style: FontSystem.KR18B),
                  ],
                ),
              );
            } else {
              return Chat(
                showUserAvatars: true,
                messages: messageViewModel.chatMessages,
                onSendPressed: (partialText) {
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
      title: Text("채팅", style: FontSystem.KR20B),
      leading: Container(
        padding: EdgeInsets.only(
          left: Get.width * 0.03,
          right: Get.width * 0.03,
        ),
        child: InkWell(
          onTap: () {
            messageViewModel.clearChatMessages();
            RootViewModel rootViewModel = Get.put(RootViewModel());
            rootViewModel.changeIndex(0);
          },
          child: SvgPicture.asset(
            "assets/icons/back_black.svg",
          ),
        ),
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _TopButton extends StatelessWidget {
  const _TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      transformAlignment: Alignment.center,
      // 양쪽 정렬
      width: Get.width * 0.5,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA273FF),
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          if (UserPreferences.getDogId() != "") {
            Get.snackbar("잠깐만요 🐾", "입양 신청을 이미 완료하셨습니다.");
          } else {
            Get.to(PrivacyConsentScreen());
          }
        },
        child: Text(
          "입양 신청서 작성 🐾",
          style: FontSystem.KR20B.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
