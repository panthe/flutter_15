import 'package:flutter/material.dart';
import 'package:flutter_15/helper/game_table_helper.dart';
import 'package:flutter_15/models/gem_item.dart';
import 'package:flutter_15/ui/table_cell.dart';

class TableCard extends StatefulWidget {
  final List<List<GemItem>> gems;
  final double cardSize;
  final GemItem gemItem;
  final int row;
  final int col;

  const TableCard({
    Key? key,
    required this.gems,
    required this.cardSize,
    required this.gemItem,
    required this.row,
    required this.col,
  }) : super(key: key);

  @override
  _TableCardState createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white54.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1.0,
        child: Draggable(
          data: "${widget.row}_${widget.col}",
          child: GameCell(isDragging: false, cardSize: widget.cardSize, value: widget.gemItem.value ?? 0),
          feedback: GameCell(isDragging: false, cardSize: widget.cardSize, value: widget.gemItem.value ?? 0),
          childWhenDragging: GameCell(isDragging: true, cardSize: widget.cardSize, value: null),
          maxSimultaneousDrags: GameTableHelper.checkIfCanDrag(widget.row, widget.col, widget.gems) ? 1 : 0,
          onDragEnd: (details) {
            //print("Draggable End Details velocity " + details.velocity.toString());
            //print("Draggable End Details offset dx " + details.offset.dx.toString());
            //print("Draggable End Details offset dy " + details.offset.dy.toString());
            //print("Draggable End Details direction " + details.offset.direction.toString());
            //print("Draggable End Details distance " + details.offset.distance.toString());
            //print("Draggable End Details distanceSquared " + details.offset.distanceSquared.toString());
            //print("Draggable End Details isFinite " + details.offset.isFinite.toString());
            //print("Draggable End Details isInfinite " + details.offset.isInfinite.toString());
          },
        ),
    );
  }
}
