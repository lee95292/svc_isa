import 'package:flutter/material.dart';
import '../models/isa_info.dart';
import '../widgets/info_category.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: '기본정보'),
              Tab(text: '투자꿀팁'),
              Tab(text: '고급꿀팁'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                InfoCategory(category: IsaInfoCategory.basic),
                InfoCategory(category: IsaInfoCategory.investment),
                InfoCategory(category: IsaInfoCategory.advanced),
              ],
            ),
          ),
        ],
      ),
    );
  }
}