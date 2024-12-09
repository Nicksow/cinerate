import 'package:flutter/foundation.dart';

class MenuIndex with ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void updateIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}
