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

  Map<String, String> pressTimes= {'0':'0', '1':'0', '2':'0', '3':'0', '4':'0', '5':'0', '6':'0', '7':'0', '8':'0', '9':'0', '10':'0', '11':'0', '12':'0', '13':'0',
    '14':'0', '15':'0', '16':'0', '17':'0', '18':'0', '19':'0', '20':'0', '21':'0', '22':'0', '23':'0'};

  int yellowCount = 0;
  int blueCount = 0;
  bool blueMajority;
  bool yellowMajority;
  int pressCount = 0;
  String majorityChoice;
  String elapsedTime = '0';
  int points = 250;
  var now = new DateTime.now().toString();

  List<String> pattern = [];


  List<bool> flippedSquares;

  Future<http.Response> createData(String timeElapsed, List pattern, int pressCount, Map pressTimes, String date, int points) async {
      final http.Response response = await http.post(
        'https://jsonplaceholder.typicode.com/albums',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'experiment': 'IST',
          'mode' : 'fixed win condition',
          'version' : '1.0',
          'modality' : 'mobile',
          'subjID' : 'name',
          'study' : 'test',
          'date' : date,
          'timeElapsed': timeElapsed,
          'pattern': pattern,
          'pressCount': pressCount,
          'pressTimestamp' : pressTimes,
          'points': points
        }),
      );
      return response;
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

  List<String> createPatternList () {
    for (var i = 0; i<25; i++) {
      if (gridMap[i] == 1) {
        pattern.add('y');
      }
      else if (gridMap[i] == 2){
        pattern.add('b');
      }
      else {}
    }
    return pattern;
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
                  String elapsedTime = stopwatch.elapsedMilliseconds.toString();
                  if(flippedSquares[index] == false && index < 25){
                    for (var i = 0; i < 25; i++){
                      if (i == index) {
                        pressTimes[index.toString()] = elapsedTime;
                      }
                      else {}
                    }
                    pressCount++;
                    points = points - 10;
                    flippedSquares[index] = true;}
                  else if (index == 31) {
                    String elapsedTime = stopwatch.elapsedMilliseconds.toString();
                    stopwatch.stop();
                    stopwatch.reset();
                    majorityChoice = 'yellow';
                    List<String> pattern = createPatternList();
                    createData(elapsedTime, pattern, pressCount, pressTimes, now, points);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPagev2(
                        resultText: getCorrectMajority(majorityChoice), points: points),),);
                  }
                  else if (index == 33) {
                    String elapsedTime = stopwatch.elapsedMilliseconds.toString();
                    stopwatch.stop();
                    stopwatch.reset();
                    majorityChoice = 'blue';
                    List<String> pattern = createPatternList();
                    createData(elapsedTime, pattern, pressCount, pressTimes, now, points);
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

