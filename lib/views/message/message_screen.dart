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
import 'package:bommeong/utilities/font_system.dart';
import 'package:bommeong/views/widget/privacy/privacy_consent_screen.dart';

class MessageScreen extends BaseScreen<ChatViewModel> {
  const MessageScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final messageViewModel = Get.find<MessageViewModel>();
    final types.User user = types.User(id: const Uuid().v4());
    return Column(
          children: [
            Expanded(
              child: Obx(() {
                if (messageViewModel.isLoading.value) {
                  // isLoading이 true일 때 로딩 인디케이터를 보여줍니다.
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(), // 로딩 인디케이터
                        SizedBox(height: 20), // 인디케이터와 텍스트 사이의 공간
                        Text('강아지가 대답을 골똘히 생각중이에요..! 🐾', style: FontSystem.KR18B), // 사용자 메시지
                      ],
                    ),
                  );
                }
                // Chat 위젯을 사용하여 메시지 목록과 입력 필드를 표시합니다.
                else return Chat(
                  showUserAvatars: true,
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
      padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.width * 0.03),
      child: Row(
        //정렬
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TopButton(),
          Spacer(
            flex: 3,
          ),
          Text("채팅", style: FontSystem.KR20B),
          Spacer(flex: 7),
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

class _TopButton extends StatelessWidget {
  const _TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    MessageViewModel viewModel = Get.put(MessageViewModel());
    return InkWell(
      onTap: () {
        if(UserPreferences.getDogId() != "") {
          print(UserPreferences.getDogId());
          Get.snackbar("잠깐만요 🐾", "입양 신청을 이미 완료하셨습니다.");
        }
        else {
          RootViewModel rootViewModel = Get.put(RootViewModel());
          rootViewModel.changeIndex(6);
        }
      },
      child: Container(
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        //양쪽 정렬
        width: Get.width * 0.3,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.5),
        ),
        child: Text("입양 신청서 작성 🐾", style: FontSystem.KR14R),
      ),
    );
  }
}
