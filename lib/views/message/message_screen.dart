import 'package:bommeong/utilities/font_system.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MessageScreen extends BaseScreen<ChatViewModel> {
  const MessageScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: SvgPicture.asset(
        "assets/images/home/goBack.svg",
        height: 40,
        color: Colors.black,
      ),
    );

  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}
