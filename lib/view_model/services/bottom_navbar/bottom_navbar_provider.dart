import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
    // Use jumpToPage instead of animateToPage
    pageController.jumpToPage(newIndex);
    notifyListeners();
  }

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void disposeController() {
    pageController.dispose();
  }

  void resetIndex() {
    currentIndex = 0;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }
}
