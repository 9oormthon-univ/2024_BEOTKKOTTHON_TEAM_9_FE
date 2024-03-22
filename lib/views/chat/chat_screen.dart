import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatScreen extends BaseScreen<ChatViewModel> {
  const ChatScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {

    ChatViewModel viewModel = Get.put(ChatViewModel());

    return Column(
      children: [
        _TopBar(),
        viewModel.isHaveChat.value
            ? _ChatLogs()
            : Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Spacer(flex: 7),
                    _InitScreen(),
                    Spacer(flex: 6),
                  ],
                ),
              ),
        _BottomButton(),
      ],
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _TopBar extends StatelessWidget {
  const _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 7),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 30),
            child: Text('대화하기', style: FontSystem.KR20B)),
        Spacer(flex: 6),
        Container(
          padding: const EdgeInsets.only(right: 16),
          child: Image.asset(
            "assets/images/home/profile.png",
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}

class _InitScreen extends StatelessWidget {
  const _InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/chat/dog.svg",
          height: Get.width * 0.2,
        ),
        RichText(
          text: TextSpan(
            style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)),
            // 기본 스타일
            children: <TextSpan>[
              TextSpan(text: '아직 '),
              TextSpan(
                text: '대화기록',
                style:
                    TextStyle(color: Color(0xFFA273FF)), // '예비보호자' 부분에만 적용할 스타일
              ),
              TextSpan(text: '이 없어요.'),
            ],
          ),
        ),
        Text('봄멍에선 유기견의 페르소나와',
            style: FontSystem.KR16R.copyWith(color: Color(0xFFA273FF))),
        SizedBox(height: Get.height * 0.001),
        Text('대화할 수 있습니다.',
            style: FontSystem.KR16R.copyWith(color: Color(0xFFA273FF))),
      ],
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    MessageViewModel messageViewModel = Get.put(MessageViewModel());
    RootViewModel rootViewModel = Get.put(RootViewModel());

    return InkWell(
      onTap: () async {
        //스크린 렌더링 전에 할것

        int id = 1;
        await messageViewModel.setId(id);
        // Get.to(() => MessageScreen());
        RootViewModel rootViewModel = Get.put(RootViewModel());
        rootViewModel.changeIndex(5);
      },
      child: Container(
        width: Get.width * 0.85,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        // 패딩 조정으로 버튼 크기 조정
        decoration: BoxDecoration(
          color: Color(0xFFA273FF), // 배경색 설정
          borderRadius: BorderRadius.circular(8), // 모서리 둥글기 반경 설정
        ),
        child: Text(
          '랜덤으로 강아지와 얘기해보기!', // 버튼 텍스트
          style: FontSystem.KR16B.copyWith(color: Colors.white), // 텍스트 스타일
          textAlign: TextAlign.center, // 텍스트 정렬
        ),
      ),
    );
  }
}

class _ChatLogs extends StatelessWidget {
  const _ChatLogs({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatViewModel viewModel = Get.put(ChatViewModel());
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: PagedListView<int, ChatList>(
          pagingController: viewModel.pagingController,
          builderDelegate: PagedChildBuilderDelegate<ChatList>(
            itemBuilder: (context, item, index) => Container(
              // 아이템 빌드 로직
              padding: EdgeInsets.all(0),
              child:
                  _LogComponent(item: item), // DogComponent 대신 실제 컴포넌트를 사용하세요.
            ),
          ),
        ),
      ),
    );
  }
}

class _LogComponent extends StatelessWidget {
  const _LogComponent({super.key, required this.item});

  final ChatList item;

  @override
  Widget build(BuildContext context) {
    ChatViewModel viewModel = Get.put(ChatViewModel());
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0), // 원하는 반경 값으로 조절
                    child: Image.network(
                      item.imagePath, // 이미지 URL
                      height: 43,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name, style: FontSystem.KR18B),
                          ],
                        ),
                        Text(item.status,
                            style: FontSystem.KR14R.copyWith(color: Color(0xFFADADAD))),
                      ],
                    ),
                  ),
                ],
              ),
              Text(viewModel.formatChatDate(item.date),
                  style:
                  FontSystem.KR14M.copyWith(color: Color(0xFFADADAD))),
            ],

          ),
          SizedBox(height: 15),
          Container(
            color: Color(0xFFE5E5E5),
            height: Get.height * 0.001,
          )
        ],
      ),
    );
  }
}
