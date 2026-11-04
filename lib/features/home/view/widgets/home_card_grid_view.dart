import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/core/routing/app_routes.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';
import 'package:life_cycle/features/home/view/widgets/home_card.dart';
import 'package:life_cycle/features/home/view/widgets/home_card_list.dart';

class HomeCardGridView extends StatelessWidget {
  const HomeCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: homeCards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        return HomeCard(
          homeCardModel: homeCards[index],
          onTap: () {
            if (homeCards[index].title == 'Prayer') {
              Navigator.pushNamed(context, Routes.settingScreen);
            } else {
              context.read<ButtonNavBarCubit>().changeIndex(index + 1);
            }
          },
        );
      },
    );
  }
}
