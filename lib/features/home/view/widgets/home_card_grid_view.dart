
import 'package:flutter/material.dart';
import 'package:life_cycle/features/home/view/widgets/home_card.dart';
import 'package:life_cycle/features/home/view/widgets/home_card_list.dart';

class HomeCardGridView extends StatelessWidget {
  const HomeCardGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeCards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          return HomeCard(
            homeCardModel: homeCards[index],
          );
        },
      ),
    );
  }
}
