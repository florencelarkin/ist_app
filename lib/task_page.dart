import 'package:flutter/material.dart';
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
    13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:3, 26:3, 27:3,28:3, 29:3, 30:3, 31:1, 32:3, 33:2, 34:3};

  int yellowCount = 0;
  int blueCount = 0;
  bool blueMajority;
  bool yellowMajority;
  int pressCount = 0;
  String majorityChoice;

  List<bool> flippedSquares;

  void getSquareColor () {
    for (var i = 0; i < 25; i++) {
      int randomNumber = Random().nextInt(2) + 1;
      if (randomNumber == 1) {
        gridMap.update(i, (int randomNumber) => 1);
        yellowCount++;
      }
      else if (randomNumber == 2) {
        gridMap.update(i, (int randomNumber) => 2);
        blueCount++;
      }
    }
  }

  void getCorrectMajority(String majorityChoice) {
    if (majorityChoice == 'yellow'){
      if (yellowCount > blueCount) {
        yellowMajority = true;
        print('you are correct! the majority is yellow');
      }
      else {
        yellowMajority = false;
        print('you are wrong:(');
      }
    }
    else if (majorityChoice == 'blue') {
      if (blueCount > yellowCount) {
        blueMajority = true;
        print('you are correct! the majority is blue');
      }
      else {
        blueMajority = false;
        print('you are wrong:(');
      }
    }

  }

  void initList () {
    flippedSquares = List.generate(gridMap.length, (i) {
      return false;
  });
  }

  @override
  void initState() {
    super.initState();
    initList();
    getSquareColor();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
        itemCount: gridMap.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5),
        itemBuilder: (context, index) {
            if (index < 25) {
              if (flippedSquares[index] == false) {
                squareColor = Colors.grey;
              }
              else {
                if (gridMap[index] == 1) {
                  squareColor = Colors.yellow;
                }
                else if (gridMap[index] == 2) {
                  squareColor = Colors.blue;
                }
              }
            }
            else if (gridMap[index] == 3){
              squareColor = Color(0xFF0A0E21);
            }
            else if (gridMap[index] == 1) {
                squareColor = Colors.yellow;
            }
            else if (gridMap[index] == 2) {
              squareColor = Colors.blue;
            }


          return GridSquare(
            color: squareColor,
            onPress: () {
              setState(() {
                if(flippedSquares[index] == false && index < 25){
                  pressCount++;
                  flippedSquares[index] = true;}
                else if (index == 31) {
                  majorityChoice = 'yellow';
                  getCorrectMajority(majorityChoice);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),),);
                }
                else if (index == 33) {
                  majorityChoice = 'blue';
                  getCorrectMajority(majorityChoice);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),),);
                }
                else {}
              },);
            },
          );
        }
      ),
    );
  }
}
