class ShantenCalculator {
  //pseudoglobals for Standard Shanten calculation
  int completeSets = 0;
  int pair = 0;
  int partialSets = 0;
  int bestShanten = 8;
  int handType = 0;

  void resetParams() {
    completeSets = 0;
    pair = 0;
    partialSets = 0;
    bestShanten = 8;
    handType = 0;
  }

  int calculateMinimumShanten(List<int> handToCheck) {
    resetParams();
    int chiitoiShanten = calculateChiitoitsuShanten(handToCheck);

    if (chiitoiShanten < 0) {
      handType = 1;
      return chiitoiShanten;
    }

    int kokushiShanten = calculateKokushiShanten(handToCheck);

    if (kokushiShanten < 3) {
      handType = 2;
      return kokushiShanten;
    }

    int standardShanten = calculateStandardShanten(handToCheck);

    List<int> shantens = [standardShanten, chiitoiShanten, kokushiShanten];
    int currMin = standardShanten;
    for (int i = 1; i < 3; i++) {
      if (shantens[i] < currMin) {
        currMin = shantens[i];
        handType = i;
      }
    }
    return currMin;
  }

  int calculateChiitoitsuShanten(List<int> hand) {
    int pairCount = 0, uniqueTiles = 0;

    for (int i = 0; i < hand.length; i++) {
      if (hand[i] == 0) continue;

      uniqueTiles++;

      if (hand[i] >= 2) {
        pairCount++;
      }
    }

    int shanten = 6 - pairCount;

    if (uniqueTiles < 7) {
      shanten += 7 - uniqueTiles;
    }

    return shanten;
  }

  int calculateKokushiShanten(List<int> handToCheck) {
    int uniqueTiles = 0;
    int hasPair = 0;

    for (int i = 0; i < handToCheck.length; i++) {
      if (i % 9 == 0 || i % 9 == 8 || i > 27) {
        if (handToCheck[i] != 0) {
          uniqueTiles++;

          if (handToCheck[i] >= 2) {
            hasPair = 1;
          }
        }
      }
    }

    return 13 - uniqueTiles - hasPair;
  }

  int calculateStandardShanten(List<int> hand) {
    for (int i = 0; i < hand.length; i++) {
      if (hand[i] >= 2) {
        pair++;
        hand[i] -= 2;
        removeCompletedSets(hand, 0);
        hand[i] += 2;
        pair--;
      }
    }

    removeCompletedSets(hand, 0);

    return bestShanten;
  }

  void removeCompletedSets(List<int> hand, int i) {
    if (bestShanten <= -1) return;

    for (; i < hand.length && hand[i] == 0; i++) {}

    if (i >= hand.length) {
      removePotentialSets(hand, 0);
      return;
    }

    if (hand[i] >= 3) {
      completeSets++;
      hand[i] -= 3;
      removeCompletedSets(hand, i);
      hand[i] += 3;
      completeSets--;
    }

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

  void removePotentialSets(List<int> hand, int i) {
    if (bestShanten <= -1) return;

    for (; i < hand.length && hand[i] == 0; i++) {}

    if (i >= hand.length) {
      int currentShanten = 8 - (completeSets * 2) - partialSets - pair;
      if (currentShanten < bestShanten) {
        bestShanten = currentShanten;
      }
      return;
    }

    if (completeSets + partialSets < 4) {
      if (hand[i] == 2) {
        partialSets++;
        hand[i] -= 2;
        removePotentialSets(hand, i);
        hand[i] += 2;
        partialSets--;
      }

      if (i < 26 && i != 8 && i != 17 && hand[i + 1] != 0) {
        partialSets++;
        hand[i]--;
        hand[i + 1]--;
        removePotentialSets(hand, i);
        hand[i]++;
        hand[i + 1]++;
        partialSets--;
      }

      if (i < 25 &&
          i != 7 &&
          i != 8 &&
          i != 16 &&
          i != 17 &&
          hand[i + 2] != 0) {
        partialSets++;
        hand[i]--;
        hand[i + 2]--;
        removePotentialSets(hand, i);
        hand[i]++;
        hand[i + 2]++;
        partialSets--;
      }
    }

    removePotentialSets(hand, i + 1);
  }
}

//pass in a 13-tile hand and obtain the ukeire of the hand.
int calculateUkeire(List<int> hand) {
  ShantenCalculator sCalc = ShantenCalculator();
  int finalUkeire = 0;
  int initShanten = sCalc.calculateMinimumShanten(hand);

  for (int i = 0; i < hand.length; i++) {
    if (hand[i] < 4) {
      hand[i] += 1;
      int shanten = sCalc.calculateMinimumShanten(hand);
      if (shanten < initShanten) {
        finalUkeire += (4 - hand[i] + 1);
      }
      hand[i] -= 1;
    }
  }

  return finalUkeire;
}

class Result {
  int bestTile;
  int shanten;
  int ukeire;
  int handType;

  Result(this.bestTile, this.shanten, this.ukeire, this.handType);
}

//take in 14-tile hand
Result findBestDiscard(List<int> hand) {
  ShantenCalculator sCalc = ShantenCalculator();
  int initShanten = sCalc.calculateMinimumShanten(hand);

  int bestTile = 0;
  int ukeire = 0;
  int handType = sCalc.handType;

  for (int i = 0; i < hand.length; i++) {
    if (hand[i] != 0) {
      hand[i] -= 1;
      if (sCalc.calculateMinimumShanten(hand) == initShanten) {
        int tempUkeire = calculateUkeire(hand);
        if (tempUkeire > ukeire) {
          bestTile = i;
          ukeire = tempUkeire;
          handType = sCalc.handType;
        }
      }
      hand[i] += 1;
    }
  }

  return Result(bestTile, initShanten, ukeire, handType);
}

void main() {
  List<int> rawHand = [2, 3, 4, 5, 6, 14, 17, 14, 17, 17, 3, 23, 24, 3];
  List<int> hand = List<int>.filled(34, 0);
  for (int i = 0; i < rawHand.length; i++) {
    hand[rawHand[i]] += 1;
  }
  // for (int i = 0; i < 3; i++) {
  //   hand[9 * i] = 1;
  //   hand[9 * i + 8] = 1;
  // }
  // for (int i = 27; i < 34; i++) {
  //   hand[i] = 1;
  // }
  //hand[1] = 1;
  Result result = findBestDiscard(hand);
  print(
      '${result.bestTile}, ${result.shanten}, ${result.ukeire}, ${result.handType}');
}
