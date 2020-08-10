import 'package:flutter/material.dart';
import 'package:istapp/result_page.dart';
import 'package:istapp/grid_square.dart';
import 'dart:math';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Color squareColor;

  Stopwatch stopwatch = new Stopwatch()..start();

  Map<int, int> gridMap  = {0: 0, 1: 0, 2: 0, 3: 0, 4:0,5:0, 6: 0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0,
    13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:3, 26:3, 27:3,28:3, 29:3, 30:3, 31:1, 32:3, 33:2, 34:3};

  int yellowCount = 0;
  int blueCount = 0;
  int pressCount = 0;
  String majorityChoice;
  int elapsedTime = 0;

  List<bool> flippedSquares;

  Future<http.Response> createData(String timeElapsed, Map pattern, int pressCount, Map pressTimes, String date, String time) {
    return http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'experiment': 'IST',
        'version' : '1.0',
        'modality' : 'mobile',
        'subjID' : '0',
        'date' : date,
        'time' : time,
        'study' : 'test',
        'timeElapsed': timeElapsed,
        'pattern': pattern,
        'pressCount': pressCount,
        'pressTimestamp' : pressTimes
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
        return result;

      }
      else {
        result = 'You lose';
        return result;
      }
    }
    else if (majorityChoice == 'blue') {
      if (blueCount > yellowCount) {
        result = 'You win!';
        return result;
      }
      else {
        result = 'You lose';

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
                  stopwatch.stop();
                  elapsedTime = stopwatch.elapsedMilliseconds;
                  print(elapsedTime);
                  stopwatch.reset();
                  majorityChoice = 'yellow';
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(
                    resultText: getCorrectMajority(majorityChoice)),),);
                }
                else if (index == 33) {
                  stopwatch.stop();
                  elapsedTime = stopwatch.elapsedMilliseconds;
                  print(elapsedTime);
                  stopwatch.reset();
                  majorityChoice = 'blue';
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(
                    resultText: getCorrectMajority(majorityChoice)), ),);
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
