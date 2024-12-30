import 'package:flutter/material.dart';

import '../widgets/tax_comparison_graph/tax_graph.dart';
import '../widgets/tax_comparison_graph/tax_graph_legend.dart';
import '../widgets/tax_comparison_table.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '수익금에 따른 세금 비교',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TaxComparisonGraph(),
                  const TaxGraphLegend(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TaxComparisonTable(),
          ],
        ),
      ),
    );
  }
}
