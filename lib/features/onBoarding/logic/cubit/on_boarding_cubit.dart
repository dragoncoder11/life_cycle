
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:life_cycle/core/utils/caching.dart';
import 'package:meta/meta.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int startIndex = 0;

  bool isCompleted = false;

  PageController pageController = PageController();

 // final Cache cache = Cache();

  Future<void> checkOnBoarding() async {
  //  await cache.cacheInitialization();

    isCompleted = Cache.instance.getData('isCompleted') ?? false;

    emit(CheckOnBoardingCompleted());
  }

  Future<void> completeOnBoarding() async {
    await Cache.instance.setData('isCompleted', true);

    isCompleted = true;

    emit(CheckOnBoardingCompleted());
  }

  void changeIndex(int index) {
    if (startIndex == index) return;

    startIndex = index;

    emit(ChangeIndex());
  }

  void nextPage() {
    if (startIndex < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
