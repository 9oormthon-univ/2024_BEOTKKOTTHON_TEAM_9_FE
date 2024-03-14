import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';

class DogInfoScreen extends BaseScreen<DogInfoViewModel> {
  const DogInfoScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Text('Dog info Screen');
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

}