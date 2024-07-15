import 'ShantenCalculator.dart';
import 'RefLists.dart';

class ScoreInfo {
  int score = 0;
  List<String> taiList = [];
}

class ValueCalculator {
  ScoreInfo getScoreInfo(
      Result result, List<int> hand, int tableWindIdx, int seatWindIdx) {
    ScoreInfo finalScoreInfo = ScoreInfo();
    if (isKokushi(result)) {
      finalScoreInfo.score = 5; //default max score
      finalScoreInfo.taiList.add("Thirteen Orphans");
      return finalScoreInfo;
    }
    if (isTsuuIiSou(hand)) {
      finalScoreInfo.score = 5; //default max score
      finalScoreInfo.taiList.add("All Honors");
      return finalScoreInfo;
    }

    int chinHonStatus = isChinOrHonitsu(hand);
    if (chinHonStatus == 1) {
      finalScoreInfo.score += 2;
      finalScoreInfo.taiList.add("Half Flush");
    } else if (chinHonStatus == 2) {
      finalScoreInfo.score += 4;
      finalScoreInfo.taiList.add("Full Flush");
    }

    if (isChiitoi(result)) {
      finalScoreInfo.score += 2;
      finalScoreInfo.taiList.add("Seven Pairs");
      return finalScoreInfo;
    }

    PinfuChecker pfc = PinfuChecker();
    if (pfc.isPinfu(hand)) {
      finalScoreInfo.score += 4;
      finalScoreInfo.taiList.add('Pinfu');
      return finalScoreInfo;
    }

    if (isToitoi(hand)) {
      finalScoreInfo.score += 2;
      finalScoreInfo.taiList.add('Peng Peng');
    }

    if (hand[tableWindIdx] == 3) {
      finalScoreInfo.score += 1;
      finalScoreInfo.taiList.add('Table Wind');
    }

    if (hand[seatWindIdx] == 3) {
      finalScoreInfo.score += 1;
      finalScoreInfo.taiList.add('Seat Wind');
    }

    for (int i = 31; i < 34; i++) {
      if (hand[i] == 3) {
        finalScoreInfo.score += 1;
        finalScoreInfo.taiList.add(tileCode[i]);
      }
    }
    return finalScoreInfo;
  }
  //check kokushi
  //check tsuuiisou
  //check chiitoi
  //check chinitsu / honitsu
  //assert std hand
  //check for toitoi
  //check for pinfu
  //check for winds/honors
  //check for chinitsu/honitsu

  bool isKokushi(Result result) {
    return (result.handType == 2 && result.shanten == -1);
  }

  bool isTsuuIiSou(List<int> hand) {
    for (int i = 0; i < 27; i++) {
      if (hand[i] != 0) {
        return false;
      }
    }
    return true;
  }

  bool isChiitoi(Result result) {
    return (result.handType == 1 && result.shanten == -1);
  }

  int isChinOrHonitsu(List<int> hand) {
    int hasMan = 0;
    int hasSou = 0;
    int hasPin = 0;
    bool hasHonors = false;

    for (int i = 0; i < 9; i++) {
      if (hand[i] != 0) {
        hasMan = 1;
      }
    }
    for (int i = 9; i < 18; i++) {
      if (hand[i] != 0) {
        hasSou = 1;
      }
    }
    for (int i = 18; i < 27; i++) {
      if (hand[i] != 0) {
        hasPin = 1;
      }
    }
    for (int i = 27; i < 34; i++) {
      if (hand[i] != 0) {
        hasHonors = true;
      }
    }
    if (hasMan + hasSou + hasPin == 1) {
      if (hasHonors) {
        return 1; //honitsu
      }
      return 2; //chinitsu
    }
    return 0; //neither
  }

  bool isToitoi(List<int> hand) {
    int tripletCount = 0;
    int pair = 0;
    for (int i = 0; i < hand.length; i++) {
      if (hand[i] == 3) {
        tripletCount++;
      } else if (hand[i] == 2) {
        pair++;
      }
    }
    return (tripletCount == 4 && pair == 1);
  }
  //check for pinfu
  //check for winds/honors
}

class PinfuChecker {
  int completeSets = 0;
  int pair = 0;
  int partialSets = 0;
  int bestShanten = 8;
  //int handType = 0;

  bool isPinfu(List<int> hand) {
    for (int i = 0; i < hand.length; i++) {
      if (hand[i] >= 2) {
        pair++;
        hand[i] -= 2;
        removeCompletedSets(hand, 0);
        hand[i] += 2;
        pair--;
      }
    }

    //removeCompletedSets(hand, 0);

    return (bestShanten == -1);
  }

  void removeCompletedSets(List<int> hand, int i) {
    if (bestShanten <= -1) return;

    for (; i < hand.length && hand[i] == 0; i++) {}

    if (i >= hand.length) {
      int currentShanten = 8 - (completeSets * 2) - partialSets - pair;
      if (currentShanten < bestShanten) {
        bestShanten = currentShanten;
      }
      return;
    }

    // if (hand[i] >= 3) {
    //   completeSets++;
    //   hand[i] -= 3;
    //   removeCompletedSets(hand, i);
    //   hand[i] += 3;
    //   completeSets--;
    // }

    if (i < 25 && (i % 9 < 7) && hand[i + 1] != 0 && hand[i + 2] != 0) {
      completeSets++;
      hand[i]--;
      hand[i + 1]--;
      hand[i + 2]--;
      removeCompletedSets(hand, i);
      hand[i]++;
      hand[i + 1]++;
      hand[i + 2]++;
      completeSets--;
    }

    removeCompletedSets(hand, i + 1);
  }

  // void removePotentialSets(List<int> hand, int i) {
  //   if (bestShanten <= -1) return;

  //   for (; i < hand.length && hand[i] == 0; i++) {}

  //   if (i >= hand.length) {
  //     int currentShanten = 8 - (completeSets * 2) - partialSets - pair;
  //     if (currentShanten < bestShanten) {
  //       bestShanten = currentShanten;
  //     }
  //     return;
  //   }

  //   if (completeSets + partialSets < 4) {
  //     if (hand[i] == 2) {
  //       partialSets++;
  //       hand[i] -= 2;
  //       removePotentialSets(hand, i);
  //       hand[i] += 2;
  //       partialSets--;
  //     }

  //     if (i < 26 && i != 8 && i != 17 && hand[i + 1] != 0) {
  //       partialSets++;
  //       hand[i]--;
  //       hand[i + 1]--;
  //       removePotentialSets(hand, i);
  //       hand[i]++;
  //       hand[i + 1]++;
  //       partialSets--;
  //     }

  //     if (i < 25 &&
  //         i != 7 &&
  //         i != 8 &&
  //         i != 16 &&
  //         i != 17 &&
  //         hand[i + 2] != 0) {
  //       partialSets++;
  //       hand[i]--;
  //       hand[i + 2]--;
  //       removePotentialSets(hand, i);
  //       hand[i]++;
  //       hand[i + 2]++;
  //       partialSets--;
  //     }
  //   }

  //   removePotentialSets(hand, i + 1);
  // }
}

void main() {
  List<int> tileCount = [
    2,
    2,
    3,
    1,
    0,
    0,
    1,
    1,
    1, //9-man
    0,
    0,
    0,
    2,
    0,
    0,
    0,
    0,
    1, //9-s?
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0, //9p?
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  PinfuChecker pfc = PinfuChecker();
  print(tileCount);
  print(pfc.isPinfu(tileCount));
}
