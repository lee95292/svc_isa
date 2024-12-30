import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

import '../theme/app_colors.dart';
import 'graph_screen.dart';
import 'info_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Row(
            children: [
              Icon(Icons.account_balance, color: AppColors.cardBackground),
              const SizedBox(width: 8),
              Text(
                'ISA 정보공유',
                style: TextStyle(
                  color: AppColors.cardBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: AppColors.cardBackground,
            labelColor: AppColors.cardBackground,
            unselectedLabelColor: AppColors.cardBackground.withOpacity(0.7),
            tabs: const [
              Tab(
                icon: Icon(Icons.show_chart),
                text: '수익률 계산기',
              ),
              Tab(
                icon: Icon(Icons.info_outline),
                text: 'ISA 정보',
              ),
            ],
          ),
        ),
        body: Seo.head(
          tags: [
            MetaTag(name: 'title', content: 'ISA 절세 계산기'),
            MetaTag(
                name: 'description',
                content:
                    'ISA 절세 계산 및 ISA의 각종 혜택을 확인할 수 있습니다. ISA 절세금액, 가입조건, 투자 관련 팁 등을 확인 할 수 있습니다. '),
            MetaTag(name: 'og:title', content: 'ISA 절세 계산기'),
            MetaTag(
                name: 'og:description',
                content:
                    'SA 절세 계산 및 ISA의 각종 혜택을 확인할 수 있습니다. ISA 절세금액, 가입조건, 투자 관련 팁 등을 확인 할 수 있습니다.'),
            MetaTag(name: 'robots', content: 'index,follow'),
          ],
          child: Container(
            color: AppColors.background,
            child: const TabBarView(
              children: [
                GraphScreen(),
                InfoScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
