import 'package:flutter/material.dart';
import 'package:flutter_15/helper/game_table_helper.dart';

class GameCell extends StatefulWidget {
  final bool isDragging;
  final double cardSize;
  final int? value;
  const GameCell({
    Key? key,
    required this.isDragging,
    required this.cardSize,
    this.value,
  }) : super(key: key);

  @override
  _GameCellState createState() => _GameCellState();
}

class _GameCellState extends State<GameCell> {
  final String gemsPath = 'assets/gems/';

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: widget.cardSize,
        width: widget.cardSize,
        decoration: (widget.isDragging || widget.value == null)
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      gemsPath + GameTableHelper.getGemImage(widget.value)),
                  fit: BoxFit.contain,
                ),
                color: Colors.transparent,
              ),
        child: Center(
          child: widget.value == null
              ? SizedBox.shrink()
              : Text(
                  widget.value.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
