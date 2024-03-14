import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/views/home/home_screen.dart';
import 'package:bommeong/views/root/custom_bottom_navigation_bar.dart';

import '../../viewModels/root/root_viewmodel.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
          () => IndexedStack(
        index: viewModel.selectedIndex,
        children: const [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ],
      ),
    );
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return const CustomBottomNavigationBar();
  }


  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Color? get unSafeAreaColor => const Color(0xFF0D0B26);

  @override
  bool get setTopOuterSafeArea => false;
}