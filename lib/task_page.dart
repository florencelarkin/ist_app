import 'package:flutter/material.dart';
import 'constants.dart';
import 'result_page.dart';
import 'grid_square.dart';
import 'dart:math';


class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Color squareColor;

  Map<int, int> gridMap  = {0: 0, 1: 0, 2: 0, 3: 0, 4:0,5:0, 6: 0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0,
    13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0};

  int selectedIndex = 0;
  int yellowCount = 0;
  int blueCount = 0;
  int pressCount = 0;

  List<bool> openedSquares;

  onSelected (int index) {
    setState(() => selectedIndex = index);
  }

  void getSquareColor (int index) {
    int randomNumber = Random().nextInt(2) + 1;
    print(randomNumber);
    if (randomNumber == 1) {
      gridMap.update(index, (int randomNumber) => 1);
      yellowCount++;

    }
    else if (randomNumber == 2) {
      gridMap.update(index, (int randomNumber) => 2);
      blueCount++;
    }
  }

  void initList () {
    openedSquares = List.generate(gridMap.length, (i) {
      return false;
  });
  }

  @override
  void initState() {
    super.initState();
    initList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: GridView.builder(
        itemCount: gridMap.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5),
        itemBuilder: (context, index) {
          if(openedSquares[index] == false){
            squareColor = Colors.grey;
          }
          else{
            if (gridMap[index] == 1) {
              squareColor = Colors.yellow;
            }
            else if (gridMap[index] == 2) {
              squareColor = Colors.blue;
            }
          }
          return GridSquare(
            color: squareColor,
            onPress: () {
              setState(() {
                getSquareColor(index);
                openedSquares[index] = true;
              },);
            },
          );
        }
      ),



    );/*Column(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),

        FlatButton(
          child: Text(''),
          padding: const EdgeInsets.only(left: double.infinity, right: double.infinity, top: 40.0, ),
          color: Colors.yellow,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),
            ),
            );
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        FlatButton(
          child: Text(''),
          padding: const EdgeInsets.only(left: double.infinity, right: double.infinity, top: 40.0),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),
            ),
            );
          },
        ),
        SizedBox(
          height: 40.0,
        ),
    ],
    );*/
  }
}
