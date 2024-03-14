import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:bommeong/views/base/base_widget.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
          () => Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 65,
            color: const Color(0xFFFFFFFF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavigationBarItem(
                  index: 0,
                  size: 45,
                  svgPath: 'assets/icons/meet_g.svg',
                ),
                _buildBottomNavigationBarItem(
                  index: 1,
                  size: 45,
                  svgPath: 'assets/icons/chat.svg',
                ),
                _buildBottomNavigationBarItem(
                  index: 2,
                  size: 45,
                  svgPath: 'assets/icons/like.svg',
                ),
                _buildBottomNavigationBarItem(
                  index: 3,
                  size: 45,
                  svgPath: 'assets/icons/my.svg',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem({
    required int index,
    required double size,
    required String svgPath,
  }) =>
      Expanded(
        child: SvgPicture.asset(
          svgPath,
          height: size,
          colorFilter: viewModel.selectedIndex == index
              ? const ColorFilter.mode(Color(0xFF634EC0), BlendMode.srcATop)
              : const ColorFilter.mode(Colors.transparent, BlendMode.srcATop),
        ),
      );
}