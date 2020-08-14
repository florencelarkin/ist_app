import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:istapp/result_page_v2.dart';
import 'package:istapp/grid_square.dart';
import 'dart:math';
import 'dart:core';
import 'package:http/http.dart' as http;


class TaskPagev2 extends StatefulWidget {
  @override
  _TaskPagev2State createState() => _TaskPagev2State();
}

class _TaskPagev2State extends State<TaskPagev2> {

  Color squareColor;

  Stopwatch stopwatch = new Stopwatch()..start();

  Map<int, int> gridMap  = {0: 0, 1: 0, 2: 0, 3: 0, 4:0,5:0, 6: 0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0,
    13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:3, 26:3, 27:3,28:3, 29:3, 30:3, 31:1, 32:3, 33:2, 34:3};

  Map<int, int> pressTimes= {0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0,
    23:0, 24:0};

  int yellowCount = 0;
  int blueCount = 0;
  bool blueMajority;
  bool yellowMajority;
  int pressCount = 0;
  String majorityChoice;
  int elapsedTime = 0;
  int points = 250;
  var now = new DateTime.now();


  List<bool> flippedSquares;

  Future<http.Response> createData(int timeElapsed, Map pattern, int pressCount, Map pressTimes, dynamic date, int points) async {
    return http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'experiment': 'IST',
        'version' : '2.0',
        'modality' : 'mobile',
        'subjID' : 'name',
        'study' : 'test',
        'date' : date,
        'timeElapsed': timeElapsed,
        'pattern': pattern,
        'pressCount': pressCount,
        'pressTimestamp' : pressTimes,
        'points' : points
      }),
    );
  }

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

  String getCorrectMajority(String majorityChoice) {
    String result;
    if (majorityChoice == 'yellow'){
      if (yellowCount > blueCount) {
        result = 'You win!';
        points = points + 100;
        return result;

      }
      else {
        result = 'You lose';
        points = points - 100;
        return result;
      }
    }
    else if (majorityChoice == 'blue') {
      if (blueCount > yellowCount) {
        result = 'You win!';
        points = points + 100;
        return result;
      }
      else {
        result = 'You lose';
        points = points - 100;
        return result;
      }
    }
    else {
      return null;
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
        title: Text('Points: $points'),
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
                  elapsedTime = stopwatch.elapsedMilliseconds;
                  print(elapsedTime);
                  if(flippedSquares[index] == false && index < 25){
                    for (var i = 0; i < 25; i++){
                      if (i == index) {
                        pressTimes[index] = elapsedTime;
                      }
                      else {}
                    }
                    print(pressTimes);
                    pressCount++;
                    points = points - 10;
                    flippedSquares[index] = true;}
                  else if (index == 31) {
                    elapsedTime = stopwatch.elapsedMilliseconds;
                    stopwatch.stop();
                    stopwatch.reset();
                    majorityChoice = 'yellow';
                    createData(elapsedTime, gridMap, pressCount, pressTimes, now, points);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPagev2(
                        resultText: getCorrectMajority(majorityChoice), points: points),),);
                  }
                  else if (index == 33) {
                    elapsedTime = stopwatch.elapsedMilliseconds;
                    stopwatch.stop();
                    stopwatch.reset();
                    majorityChoice = 'blue';
                    createData(elapsedTime, gridMap, pressCount, pressTimes, now, points);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPagev2(
                        resultText: getCorrectMajority(majorityChoice), points: points),),);
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

