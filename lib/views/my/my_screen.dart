import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/my/my_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';

class MyScreen extends BaseScreen<MyViewModel> {
  const MyScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Text('My Screen');
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

}