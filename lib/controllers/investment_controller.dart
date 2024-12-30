import 'dart:math';

import 'package:get/get.dart';
import '../constants/investment_constants.dart';

class InvestmentController extends GetxController {
  // 현재 선택된 포인트 정보
  final isPointSelected = false.obs;

  // 수익금 관련 정보
  final profit = 0.0.obs;
  final normalTax = 0.0.obs;
  final isaTax = 0.0.obs;
  final normalAfterTax = 0.0.obs;
  final isaAfterTax = 0.0.obs;

  // 축 관련 정보
  final profitAxis = InvestmentConstants.MAX_PROFIT.obs;
  final taxAxis = InvestmentConstants.MAX_TAX.obs;

  // ISA 이득 요소별 계산
  final taxFreeProfit = 0.0.obs; // 비과세 혜택
  final lowTaxProfit = 0.0.obs; // 저율과세 혜택
  final totalBenefit = 0.0.obs; // 총 혜택

  @override
  void onInit() {
    super.onInit();
  }

  void calculateTax(double newProfit, double newTax) {
    profit.value = newProfit;
    normalTax.value = newTax;
    // 일반계좌 세금계산
    normalTax.value = profit.value * InvestmentConstants.NORMAL_TAX_RATE;
    normalAfterTax.value = profit.value - normalTax.value;

    // ISA계좌 세금계산
    if (profit.value <= InvestmentConstants.ISA_TAX_FREE_LIMIT) {
      isaTax.value = 0;
      taxFreeProfit.value = profit.value;
      lowTaxProfit.value = 0;
    } else {
      taxFreeProfit.value = InvestmentConstants.ISA_TAX_FREE_LIMIT;
      double excessProfit =
          profit.value - InvestmentConstants.ISA_TAX_FREE_LIMIT;
      isaTax.value = excessProfit * InvestmentConstants.ISA_TAX_RATE;
      lowTaxProfit.value = excessProfit *
          (InvestmentConstants.NORMAL_TAX_RATE -
              InvestmentConstants.ISA_TAX_RATE);
    }

    isaAfterTax.value = profit.value - isaTax.value;
    totalBenefit.value = isaAfterTax.value - normalAfterTax.value;

    // 축 업데이트
    profitAxis.value = max(profit.value * 1.5, InvestmentConstants.MAX_PROFIT);
    taxAxis.value = max(normalTax.value * 1.5, InvestmentConstants.MAX_TAX);
  }

  String formatCurrency(double value) {
    return '${value >= 0 ? "" : "-"}${(value.abs() / 10000).toStringAsFixed(0)}만원';
  }
}
