import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_15/models/gem_item.dart';

class GameTableHelper {
  static List<List<GemItem>> generateGameTable(int rows, int cols) {
    return List.generate(rows,
            (i) => List.generate(cols,
                (j) => GemItem(value: null),
            growable: false),
        growable: false);
  }

  static fullfillGemMatrix(int startRow, int rows, int cols, int minNumber, int maxNumber, List<List<GemItem>> gems){
    for (int i=startRow; i<rows;i++) {
      for (int j = 0; j < cols; j++) {
        gems[i][j].value = generateRandomNumber(minNumber,maxNumber);
      }
    }
  }

  static int generateRandomNumber(int minNumber, int maxNumber) {
    final random = new Random();
    final int value = random.nextInt(maxNumber - minNumber);
    return value == 0 ? 1 : value;
  }

  static double getCardSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int minWidth = width ~/ 8;
    int minHeigth = height ~/ 10;

    return min(minWidth, minHeigth).toDouble();
  }

  static List<int> convertDataToCoords(String data) {
    List<int> coords = List .filled(2,0);
    List<String> coordsStr = data.split("_");

    for (int i=0; i<coordsStr.length; i++) {
      try {
        coords[i] = int.parse(coordsStr[i]);
      } catch (e) {
        coords[i] = 0;
      }
    }

    return coords;
  }

  static String getGemImage(int? value) {
    String gemImage = 'gem_pink.png';
    switch (value) {
      case 0:
        gemImage = 'gem_pink.png';
        break;

      case 1:
        gemImage = 'gem_cyan.png';
        break;

      case 2:
        gemImage = 'gem_blue.png';
        break;

      case 3:
        gemImage = 'gem_purple.png';
        break;

      case 4:
        gemImage = 'gem_lightgreen.png';
        break;

      case 5:
        gemImage = 'gem_red.png';
        break;

      case 6:
        gemImage = 'gem_deeppurple.png';
        break;

      case 7:
        gemImage = 'gem_green.png';
        break;

      case 8:
        gemImage = 'gem_gold.png';
        break;

      case 9:
        gemImage = 'gem_deeporange.png';
        break;

      case 10:
        gemImage = 'gem_grey.png';
        break;

      case 11:
        gemImage = 'gem_lightblue.png';
        break;

      case 12:
        gemImage = 'gem_orange.png';
        break;

      case 13:
        gemImage = 'gem_yellow.png';
        break;

      case 14:
        gemImage = 'gem_black.png';
        break;
    }

    return gemImage;
  }

  static bool checkIfNearMatrixValueIsMatching(int rowOrigin, int colOrigin, int rowDest, int colDest, List<List<GemItem>> gems) {
    if ((colOrigin == colDest && rowOrigin == rowDest+1) || (rowDest+1 > gems.length)){
      return false;
    }
    return gems[rowOrigin][colOrigin].value == gems[rowDest+1][colDest].value;
  }

  static void printGameTable(List<List<GemItem>> gems) {
    final rows = gems.length;
    if (rows<1){
      print('Error in Gems Table');
    }
    final cols = gems[0].length;
    for (int i=0; i<rows;i++) {
      var rowValues = '';
      for (int j = 0; j < cols; j++) {
        rowValues += "{['$i','$j']} '${gems[i][j].value}' ";
      }
      print(rowValues);
    }
  }
}