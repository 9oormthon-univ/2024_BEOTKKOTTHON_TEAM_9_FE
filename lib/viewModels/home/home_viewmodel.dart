import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';


class HomeViewModel extends GetxController {
  RxBool isHaveDog = true.obs;
  final RxString selectedAddress = ''.obs;


  final PagingController<int, DogList> pagingController = PagingController(
      firstPageKey: 0);
  final GetDogList apiService = GetDogList();

  // 주소 관련 변수
  final RxString postcode = ''.obs;
  final RxString address = ''.obs;
  final RxString addressDetail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await apiService.fetchItems(pageKey);
      num pageSize = 6;
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> searchAddress() async {
    try {
      final DataModel? result = await Get.to(() => SearchingPage());
      print("Search result: $result"); // 로그 유지
      if (result != null) {
        String fullAddress = result.address ?? '';
        if (result.buildingName != null && result.buildingName!.isNotEmpty) {
          fullAddress += ' (${result.buildingName})';
        }
        print("Full address: $fullAddress"); // 로그 유지
        selectedAddress.value = fullAddress;
        print("Selected address: ${selectedAddress.value}"); // 로그 유지
        update(); // UI 업데이트를 명시적으로 트리거
      }
    } catch (error) {
      print("Error during address search: $error");
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}


class SearchingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주소 검색"),
        centerTitle: true,
      ),
      body: DaumPostcodeSearch(
        onConsoleMessage: (controller, consoleMessage) {
          String message = consoleMessage.message;
          if (message.startsWith('DATA:')) {
            final jsonString = message.substring(5);
            final data = jsonDecode(jsonString);
            Navigator.pop(context, data);
          }
        },
        onLoadError: (controller, url, code, message) =>
            print("Error: $message"),
        onLoadHttpError: (controller, url, statusCode, description) =>
            print("HTTP Error: $description"),
      ),
    );
  }
}