import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:bommeong/main_app.dart';
import 'package:bommeong/utilities/app_routes.dart';

import 'services/user_service.dart';

void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");
  await initializeDateFormatting();

  // Splash Screen Duration 1.0s
  await Future.delayed(const Duration(seconds: 1));
  Get.lazyPut(()=>AuthService());

  runApp(MainApp(initialRoute: Get.find<AuthService>().isLoggedIn ? Routes.ROOT : Routes.LOGIN));

}