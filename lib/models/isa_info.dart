enum IsaInfoCategory {
  basic,
  investment,
  advanced
}

class IsaInfo {
  final String title;
  final String content;
  final IsaInfoCategory category;

  IsaInfo({
    required this.title,
    required this.content,
    required this.category,
  });

  static List<IsaInfo> getAllInfo() {
    return [
      IsaInfo(
        category: IsaInfoCategory.basic,
        title: 'ISA란 무엇인가요?',
        content: 'ISA(개인종합자산관리계좌)는 예금, 펀드 등 다양한 금융상품을 한 계좌에서 통합 관리하면서 세제혜택을 받을 수 있는 계좌입니다.',
      ),
      IsaInfo(
        category: IsaInfoCategory.basic,
        title: 'ISA 가입대상',
        content: '만 19세 이상 국내 거주자라면 누구나 가입할 수 있습니다.',
      ),
      IsaInfo(
        category: IsaInfoCategory.investment,
        title: '분산투자의 중요성',
        content: 'ISA에서는 다양한 금융상품에 투자할 수 있어 위험을 분산시킬 수 있습니다. 한 상품에 집중투자하지 말고 적절히 분산하세요.',
      ),
      IsaInfo(
        category: IsaInfoCategory.advanced,
        title: '세제혜택 최적화 전략',
        content: '연간 수익금 400만원까지는 비과세되므로, 이를 고려하여 투자금액과 상품을 선택하는 것이 중요합니다.',
      ),
      // 추가 정보들...
    ];
  }
}