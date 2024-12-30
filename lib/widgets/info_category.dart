import 'package:flutter/material.dart';
import '../models/isa_info.dart';

class InfoCategory extends StatelessWidget {
  final IsaInfoCategory category;

  const InfoCategory({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final infoList = IsaInfo.getAllInfo()
        .where((info) => info.category == category)
        .toList();

    return ListView.builder(
      itemCount: infoList.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(infoList[index].title),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(infoList[index].content),
            ),
          ],
        );
      },
    );
  }
}