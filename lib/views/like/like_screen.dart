import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';

class LikeScreen extends BaseScreen<LikeViewModel> {
  const LikeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Text('Like Screen');
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

}