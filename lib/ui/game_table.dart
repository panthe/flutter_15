import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_15/helper/game_table_helper.dart';
import 'package:flutter_15/ui/table_card.dart';
import 'dart:math';

import 'package:flutter_15/ui/table_cell.dart';

const int rows = 8;
const int cols = 6;
const int minNumber = 2;
const int maxNumber = 8;
const int startRow = 5;
const String gemsPath = 'assets/gems/';

class GameTable extends StatefulWidget {
  GameTable({Key? key}) : super(key: key);

  @override
  _GameTableState createState() => _GameTableState();
}

class _GameTableState extends State<GameTable> {
  double _cardSize = 0;
  var _gems = GameTableHelper.generateGameTable(rows, cols);

  @override
  void initState() {
    super.initState();
    GameTableHelper.fullfillGemMatrix(startRow, rows, cols, minNumber, maxNumber, _gems);
    //print(_gems);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    final newCardSize = GameTableHelper.getCardSize(context);
    if (newCardSize != _cardSize) {
      print('didChangeDependencies changeCardSize');
      setState(() {
        _cardSize = newCardSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            : TableCard(
          title: "${rowIndex}_$colIndex",
          cardSize: _cardSize,
          gemItem: _gems[rowIndex][colIndex],
        )
    );
  }

  DragTarget _generateDragTarget(int rowIndex, int colIndex) {
    List<int> targetCoords = [rowIndex,colIndex];
    return DragTarget(builder: (context, candidateData, rejectedData) {
      return Card(
          color: Colors.white54.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1.0,
          child: GameCell(isDragging: false, cardSize: _cardSize, value: null)
        );
      }, onWillAccept: (data) {
        //print("Will Accept -> " + (data?.toString() ?? ''));
        List<int> coords = GameTableHelper.convertDataToCoords((data?.toString() ?? ''));
        //print("Gem Coords -> " + coords.toString());
        //print("Target Coords -> " + targetCoords.toString());

        return true;
      }, onAccept: (data) {
        //print("onAccept");
        List<int> coords = GameTableHelper.convertDataToCoords((data?.toString() ?? ''));
        _checkNearMatrixValue(coords[0],coords[1], targetCoords[0], targetCoords[1]);
      }, onAcceptWithDetails: (details) {
        //print("onAccept Details offset dx " + details.offset.dx.toString());
        //print("onAccept Details offset dy " + details.offset.dy.toString());
        //print("onAccept Details direction " + details.offset.direction.toString());
        //print("onAccept Details distance " + details.offset.distance.toString());
        //print("onAccept Details distanceSquared " + details.offset.distanceSquared.toString());
        //print("onAccept Details isFinite " + details.offset.isFinite.toString());
        //print("onAccept Details isInfinite " + details.offset.isInfinite.toString());
        //_printGameTable();
      }
    );
  }

  void _checkNearMatrixValue(int rowOrigin, int colOrigin, int rowDest, int colDest) {
    var isMatching = GameTableHelper.checkIfNearMatrixValueIsMatching(rowOrigin, colOrigin, rowDest, colDest, _gems);
    print("isMatching $isMatching");
    if (isMatching) {
      setState(() {
        _gems[rowOrigin][colOrigin].value = null;
        _gems[rowOrigin][colOrigin].isDestroying = true;
        _gems[rowDest+1][colDest].value = null;
        _gems[rowDest+1][colDest].isDestroying = true;
      });
    }
  }
}
