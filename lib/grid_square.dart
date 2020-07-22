import 'package:flutter/material.dart';



class GridSquare extends StatefulWidget {
  GridSquare({@required this.color, this.onPress});
  final Color color;
  final Function onPress;

  @override
  _GridSquareState createState() => _GridSquareState();
}


class _GridSquareState extends State<GridSquare> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: widget.color,
        ),
      ),
    );
  }
}


