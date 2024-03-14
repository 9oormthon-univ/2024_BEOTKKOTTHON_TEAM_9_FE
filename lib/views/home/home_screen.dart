import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Text('Home Screen');
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

}