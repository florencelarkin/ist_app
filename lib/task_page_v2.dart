import 'dart:io';
import 'package:flutter/material.dart';
import 'package:istapp/result_page_v2.dart';
import 'package:istapp/grid_square.dart';
import 'dart:math';
import 'dart:core';
import 'data.dart';
import 'package:flutter/foundation.dart';

class TaskPagev2 extends StatefulWidget {
  TaskPagev2(
      {@required this.subjectId,
      @required this.uuid,
      this.trialNumber,
      this.blockNumber});
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  @override
  _TaskPagev2State createState() => _TaskPagev2State(
      subjectId: subjectId,
      uuid: uuid,
      trialNumber: trialNumber,
      blockNumber: blockNumber);
}

class _TaskPagev2State extends State<TaskPagev2> {
  _TaskPagev2State(
      {@required this.subjectId,
      @required this.uuid,
      this.trialNumber,
      this.blockNumber});

  String subjectId;
  String uuid;
  int trialNumber;
  int blockNumber;
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
  Map pattern = {};
  Map dataMap = {'\"version\"': 2};
  List movesList = [];
  var startTime;

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

  Map createDataList(pattern, totalTime, majorityChoice, points) {
    dataMap['\"grid\"'] = pattern;
    dataMap['\"total time\"'] = totalTime;
    getCorrectMajority(majorityChoice);
    dataMap['\"points\"'] = points;
    return dataMap;
  }

  Map createPatternList() {
    for (var i = 0; i < 25; i++) {
      if (gridMap[i] == 1) {
        pattern['\"$i\"'] = '\"yellow\"';
      } else if (gridMap[i] == 2) {
        pattern['\"$i\"'] = '\"blue\"';
      } else {}
    }
    return pattern;
  }

  String getCorrectMajority(String majorityChoice) {
    dataMap['\"version\"'] = 2;
    String result;
    if (majorityChoice == 'yellow') {
      dataMap['\"picked\"'] = '\"yellow\"';
      if (yellowCount > blueCount) {
        dataMap['\"answer\"'] = '\"correct\"';
        result = 'You win!';
        points = points + 100;
        return result;
      } else {
        dataMap['\"answer\"'] = '\"incorrect\"';
        result = 'You lose';
        points = points - 100;
        return result;
      }
    } else if (majorityChoice == 'blue') {
      dataMap['\"picked\"'] = '\"blue\"';
      if (blueCount > yellowCount) {
        dataMap['\"answer\"'] = '\"correct\"';
        result = 'You win!';
        points = points + 100;
        return result;
      } else {
        dataMap['\"answer\"'] = '\"incorrect\"';
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

  bool webFlag = false; // true if running web
  String platformType = ""; // the platform: android, ios, windows, linux
  final String taskVersion = "ist:0.1";

  void checkWebPlatform() {
    // check the platform and whether web

    if (kIsWeb) {
      webFlag = true;
    } else {
      webFlag = false;

      platformType = Platform.operatingSystem;
      // now check platform
      /*
      if(Platform.isAndroid) {
        platformType = 'android';
      } else if (Platform.isIOS) {
        platformType = 'ios';
      } else if (Platform.isLinux) {
        platformType = 'linux';
      } else if (Platform.isWindows) {
        platformType = 'windows';
      } else if (Platform.isMacOS) {
        platformType = 'macos';
      } else if (Platform.isFuchsia) {
        platformType = 'fuchsia';
      }
       */
    }
  }

  String addQuotesToString(String text) {
    var quoteText = '\"' + text + '\"';
    return quoteText;
  }

  @override
  void initState() {
    super.initState();
    startTime = new DateTime.now();
    movesList.add([
      '\"location\"',
      '\"time\"',
    ]);
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
                      movesList.add([index, elapsedTime, points]);
                      pressCount++;
                      flippedSquares[index] = true;
                    } else if (index == 31) {
                      var endTime = new DateTime.now();
                      dataMap[addQuotesToString("TaskVersion")] =
                          addQuotesToString(taskVersion);
                      dataMap[addQuotesToString("Platform")] =
                          addQuotesToString(platformType);
                      dataMap[addQuotesToString("Web")] = webFlag;
                      //dataMap[addQuotesToString("DartVersion")] = addQuotesToString(Platform.version);
                      // has double quoted android_ia32

                      dataMap['\"SubjectID\"'] = addQuotesToString(subjectId);
                      dataMap['\"StartTime\"'] =
                          addQuotesToString(startTime.toIso8601String());
                      dataMap['\"EndTime\"'] =
                          addQuotesToString(endTime.toIso8601String());

                      dataMap['\"Moves\"'] = movesList;
                      stopwatch.stop();
                      stopwatch.reset();
                      majorityChoice = 'yellow';
                      Map pattern = createPatternList();
                      String dataString = createDataList(
                              pattern, elapsedTime, majorityChoice, points)
                          .toString();
                      createData('IST', uuid, dataString, '0.1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPagev2(
                              resultText: getCorrectMajority(majorityChoice),
                              points: points),
                        ),
                      );
                    } else if (index == 33) {
                      var endTime = new DateTime.now();
                      dataMap[addQuotesToString("TaskVersion")] =
                          addQuotesToString(taskVersion);
                      dataMap[addQuotesToString("Platform")] =
                          addQuotesToString(platformType);
                      dataMap[addQuotesToString("Web")] = webFlag;
                      //dataMap[addQuotesToString("DartVersion")] = addQuotesToString(Platform.version);
                      // has double quoted android_ia32

                      dataMap['\"SubjectID\"'] = addQuotesToString(subjectId);
                      dataMap['\"StartTime\"'] =
                          addQuotesToString(startTime.toIso8601String());
                      dataMap['\"EndTime\"'] =
                          addQuotesToString(endTime.toIso8601String());
                      dataMap['\"Moves\"'] = movesList;
                      stopwatch.stop();
                      elapsedTime = stopwatch.elapsedMilliseconds.toString();
                      stopwatch.reset();
                      majorityChoice = 'blue';
                      Map pattern = createPatternList();
                      String dataString = createDataList(
                              pattern, elapsedTime, majorityChoice, points)
                          .toString();
                      createData('IST', uuid, dataString, '0.1');
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
