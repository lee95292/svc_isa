import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isa_info/constants/investment_constants.dart';
import '../controllers/investment_controller.dart';
import '../theme/app_colors.dart';

class TaxComparisonTable extends StatelessWidget {
  TaxComparisonTable({super.key});
  final controller = Get.put(InvestmentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calculate, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const Text(
                    '절세효과 비교',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(3),
                },
                children: [
                  _buildTableRow(
                    '구분',
                    '일반 계좌',
                    'ISA 계좌',
                    isHeader: true,
                  ),
                  _buildTableRow(
                    '세전 수익금',
                    '${controller.profit.value.toStringAsFixed(0)}만원',
                    '${controller.profit.value.toStringAsFixed(0)}만원',
                  ),
                  _buildTableRow(
                    '세금',
                    '${controller.normalTax.value.toStringAsFixed(0)}만원',
                    '${controller.isaTax.value.toStringAsFixed(0)}만원',
                  ),
                  _buildTableRow(
                    '세후 수익금',
                    '${controller.normalAfterTax.value.toStringAsFixed(0)}만원',
                    '${controller.isaAfterTax.value.toStringAsFixed(0)}만원',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildBenefitSection(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitSection(InvestmentController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ISA 계좌 절세 혜택 분석',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildBenefitRow(
            '비과세 혜택',
            '${(controller.taxFreeProfit.value * InvestmentConstants.NORMAL_TAX_RATE).toStringAsFixed(0)}만원',
          ),
          _buildBenefitRow(
            '저율과세 혜택',
            '${controller.lowTaxProfit.value.toStringAsFixed(0)}만원',
          ),
          const Divider(),
          _buildBenefitRow(
            '총 절세액',
            '${controller.totalBenefit.value.toStringAsFixed(0)}만원',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '+ $amount',
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String normal, String isa,
      {bool isHeader = false}) {
    TextStyle style = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      fontSize: isHeader ? 14 : 13,
    );

    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey.shade100 : null,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label, style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(normal, style: style),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isa, style: style),
          ),
        ),
      ],
    );
  }
}
