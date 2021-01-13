import 'package:flutter/material.dart';
import 'package:istapp/result_page_v2.dart';
import 'package:istapp/grid_square.dart';
import 'dart:math';
import 'dart:core';
import 'data.dart';
import 'package:uuid/uuid.dart';

class TaskPagev2 extends StatefulWidget {
  @override
  _TaskPagev2State createState() => _TaskPagev2State();
}

class _TaskPagev2State extends State<TaskPagev2> {
  Color squareColor;

  Stopwatch stopwatch = new Stopwatch()..start();

  Map<int, int> gridMap = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
    15: 0,
    16: 0,
    17: 0,
    18: 0,
    19: 0,
    20: 0,
    21: 0,
    22: 0,
    23: 0,
    24: 0,
    25: 3,
    26: 3,
    27: 3,
    28: 3,
    29: 3,
    30: 3,
    31: 1,
    32: 3,
    33: 2,
    34: 3
  };

  int yellowCount = 0;
  int blueCount = 0;
  bool blueMajority;
  bool yellowMajority;
  int pressCount = 0;
  String majorityChoice;
  String elapsedTime = '0';
  int points = 250;
  Future<Data> _futureData;
  var uuid = Uuid();
  Map pattern = {};
  List dataList = ['version: 2'];
  Map pressMap = {};

  List<bool> flippedSquares;

  void getSquareColor() {
    for (var i = 0; i < 25; i++) {
      int randomNumber = Random().nextInt(2) + 1;
      if (randomNumber == 1) {
        gridMap.update(i, (int randomNumber) => 1);
        yellowCount++;
      } else if (randomNumber == 2) {
        gridMap.update(i, (int randomNumber) => 2);
        blueCount++;
      }
    }
  }

  List createDataList(pattern, totalTime, majorityChoice, points) {
    dataList.add(pattern);
    dataList.add('total time: $totalTime');
    String result = getCorrectMajority(majorityChoice);
    if (majorityChoice == 'yellow') {
      dataList.add('picked: yellow');
    } else if (majorityChoice == 'blue') {
      dataList.add('picked: blue');
    } else {}
    if (result == 'You win!') {
      dataList.add('correct choice');
    } else if (result == 'You lose') {
      dataList.add('incorrect choice');
    } else {}
    dataList.add(points);
    return dataList;
  }

  Map createPatternList() {
    for (var i = 0; i < 25; i++) {
      if (gridMap[i] == 1) {
        pattern[i] = 'yellow';
      } else if (gridMap[i] == 2) {
        pattern[i] = 'blue';
      } else {}
    }
    return pattern;
  }

  String getCorrectMajority(String majorityChoice) {
    String result;
    if (majorityChoice == 'yellow') {
      if (yellowCount > blueCount) {
        result = 'You win!';
        points = points + 100;
        return result;
      } else {
        result = 'You lose';
        points = points - 100;
        return result;
      }
    } else if (majorityChoice == 'blue') {
      if (blueCount > yellowCount) {
        result = 'You win!';
        points = points + 100;
        return result;
      } else {
        result = 'You lose';
        points = points - 100;
        return result;
      }
    } else {
      return null;
    }
  }

  void initList() {
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
        title: Text('Points: $points'),
      ),
      body: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: gridMap.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: (context, index) {
            if (index < 25) {
              if (flippedSquares[index] == false) {
                squareColor = Colors.grey;
              } else {
                if (gridMap[index] == 1) {
                  squareColor = Colors.yellow;
                } else if (gridMap[index] == 2) {
                  squareColor = Colors.blue;
                }
              }
            } else if (gridMap[index] == 3) {
              squareColor = Color(0xFF0A0E21);
            } else if (gridMap[index] == 1) {
              squareColor = Colors.yellow;
            } else if (gridMap[index] == 2) {
              squareColor = Colors.blue;
            }

            return GridSquare(
              color: squareColor,
              onPress: () {
                setState(
                  () {
                    points = points - 10;
                    String elapsedTime =
                        stopwatch.elapsedMilliseconds.toString();
                    if (flippedSquares[index] == false && index < 25) {
                      String squareColor;
                      if (gridMap[index] == 1) {
                        squareColor = 'blue';
                      } else if (gridMap[index] == 2) {
                        squareColor = 'yellow';
                      }
                      pressMap[index] = [elapsedTime, squareColor, points];
                      pressCount++;
                      flippedSquares[index] = true;
                    } else if (index == 31) {
                      String elapsedTime =
                          stopwatch.elapsedMilliseconds.toString();
                      dataList.add(pressMap);
                      stopwatch.stop();
                      stopwatch.reset();
                      majorityChoice = 'yellow';
                      Map pattern = createPatternList();
                      String dataString = createDataList(
                              pattern, elapsedTime, majorityChoice, points)
                          .toString();
                      createData('IST', uuid.v1(), dataString, '0.1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPagev2(
                              resultText: getCorrectMajority(majorityChoice),
                              points: points),
                        ),
                      );
                    } else if (index == 33) {
                      String elapsedTime =
                          stopwatch.elapsedMilliseconds.toString();
                      dataList.add(pressMap);
                      stopwatch.stop();
                      stopwatch.reset();
                      majorityChoice = 'blue';
                      Map pattern = createPatternList();
                      String dataString = createDataList(
                              pattern, elapsedTime, majorityChoice, points)
                          .toString();
                      createData('IST', uuid.v1(), dataString, '0.1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPagev2(
                              resultText: getCorrectMajority(majorityChoice),
                              points: points),
                        ),
                      );
                    } else {}
                  },
                );
              },
            );
          }),
    );
  }
}
