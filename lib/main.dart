import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isa_info/controllers/investment_controller.dart';

import 'screens/home_screen.dart';
import 'theme/app_colors.dart';

void main() {
  Get.lazyPut(() => InvestmentController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ISA 정보공유',
      theme: AppColors.theme,
      home: HomeScreen(),
    );
  }
}
