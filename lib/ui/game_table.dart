import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_15/models/gem_item.dart';

const int rows = 8;
const int cols = 6;
const int minNumber = 2;
const int maxNumber = 8;
const String gemsPath = 'assets/gems/';
class GameTable extends StatefulWidget {
  GameTable({Key key}) : super(key: key);

  @override
  _GameTableState createState() => _GameTableState();
}

class _GameTableState extends State<GameTable> {
  double _cardSize;
  var _gems = List.generate(rows,
          (i) => List.generate(cols,
              (j) => GemItem(value: null),
          growable: false),
      growable: false);

  @override
  void initState() {
    super.initState();
    _fullfillGemMatrix();
    print(_gems);
  }

  @override
  Widget build(BuildContext context) {
    _cardSize = _getCardSize(context).toDouble();
    return Align(
      alignment: Alignment.bottomCenter,
        child:Container(
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
              width: 5.0
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            gradient: new LinearGradient(
                colors: [
                  Colors.blueGrey.withOpacity(0.4),
                  Colors.deepPurple.withOpacity(1.0),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child:Table(
            defaultColumnWidth: FixedColumnWidth(_cardSize),
            children: List<TableRow>.generate(8, (rowIndex) {
              return _generateRow(rowIndex);
            }, growable: false)
          )
        )
    );
  }

  TableRow _generateRow(int rowIndex) {
    return TableRow(
        children: List<TableCell>.generate(6, (colIndex) {
      return _generateCell(rowIndex, colIndex);
    }, growable: false));
  }

  TableCell _generateCell(int rowIndex, int colIndex) {
    return TableCell(
        child: _gems[rowIndex][colIndex].value == null ?
        _generateDragTarget(rowIndex, colIndex)
            : _generateDraggable(rowIndex, colIndex)
    );
  }

  Widget _generateDraggable(int rowIndex, int colIndex) {
    return Card(
        color: Colors.white54.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1.0,
        child: Draggable(
          data: rowIndex.toString() + "_" + colIndex.toString(),
          child: _generateContainer(isDragging: false, value: _gems[rowIndex][colIndex].value),
          feedback: _generateContainer(isDragging: false, value: _gems[rowIndex][colIndex].value),
          childWhenDragging: _generateContainer(isDragging: true, value: null),
        ));
  }

  Widget _generateDragTarget(int rowIndex, int colIndex) {
    List<int> targetCoords = [rowIndex,colIndex];
    return DragTarget(builder: (context, List<String> candidateData, rejectedData) {
      return Card(
          color: Colors.white54.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          child: _generateContainer(isDragging: false, value: null)
        );
      }, onWillAccept: (data) {
        print("Will Accept -> " + data);
        List<int> coords = _convertDataToCoords(data);
        print("Gem Coords -> " + coords.toString());
        print("Target Coords -> " + targetCoords.toString());
        return true;
      }, onAccept: (data) {
        print("onAccept");
      },
    );
  }

  List<int> _convertDataToCoords(String data) {
    List<int> coords = List<int>(2);
    List<String> coordsStr = data.split("_");

    for (int i=0; i<coordsStr.length; i++) {
      try {
        coords[i] = int.parse(coordsStr[i]);
      } catch (e) {
        coords[i] = null;
      }
    }

    return coords;
  }

  Material _generateContainer({bool isDragging, int value}) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          height: _cardSize,
          width: _cardSize,
          decoration: (isDragging || value == null) ?
            null :
            BoxDecoration(
              image: DecorationImage(
                image: AssetImage(gemsPath +  _getGemImage(value)),
                fit: BoxFit.contain,
              ),
              color: Colors.transparent,
            ),
          child: Center(
            child: value == null ?
            SizedBox.shrink()
            : Text(
                value.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          )
        )
    );
  }

  int _getCardSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int minWidth = width ~/ 8;
    int minHeigth = height ~/ 10;

    return min(minWidth, minHeigth);
  }

  String _getGemImage(int value) {
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

  void _fullfillGemMatrix(){
    for (int i=rows-1; i>3;i--){
      for (int j=0; j<cols;j++){
        _gems[i][j].value = _generateRandomNumber();
      }
    }
  }

  int _generateRandomNumber() {
    final _random = new Random();
    int value = _random.nextInt(maxNumber - minNumber);
    if (value == 0)
      value = 1;
    return value;
  }

}
