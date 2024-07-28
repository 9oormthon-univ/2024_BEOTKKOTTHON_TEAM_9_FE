import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bommeong/utilities/app_routes.dart';
import 'package:bommeong/views/home/home_screen.dart';

class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;

  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    _selectedIndex = 0.obs;

  }
    void changeIndex(int index) {
      _selectedIndex.value = index;
    }
  }
