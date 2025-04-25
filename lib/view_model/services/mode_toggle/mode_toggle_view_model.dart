import 'package:flutter/foundation.dart';

class ModeToggleViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<String> get modes => ['Full Profile', 'Event Mode', 'Stealth Mode'];
  List<String> get modes2 => ['Full', 'Event', 'Stealth'];
}
