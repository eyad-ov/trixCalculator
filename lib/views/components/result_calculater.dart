

import 'package:flutter/material.dart';

class ResultCalculater extends ChangeNotifier {
  final List<int> _roundsResults = [for (int i = 0; i < 20; i++) 0];

  void changeResult(int round, int result) {
    print(round);
    _roundsResults[round] = result;
    notifyListeners();
  }

  int calculateResultOfKingdom(int kingdom) {
    int res = 0;
    for (int i = 5 * (kingdom - 1); i < 5 * (kingdom); i++) {
      res += _roundsResults[i];
    }
    return res;
  }

  int calculateResultOfGame() {
    int res = 0;
    for (int i = 0; i < 20; i++) {
      res += _roundsResults[i];
    }
    return res;
  }
}
