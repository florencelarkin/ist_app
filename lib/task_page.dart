import 'package:flutter/material.dart';
import 'package:istapp/result_page.dart';
import 'package:istapp/grid_square.dart';
import 'dart:math';
import 'dart:core';
import 'data.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class TaskPage extends StatefulWidget {
  TaskPage(
      {@required this.subjectId,
      @required this.uuid,
      this.trialNumber,
      this.blockNumber});
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  @override
  _TaskPageState createState() => _TaskPageState(
      subjectId: subjectId,
      uuid: uuid,
      trialNumber: trialNumber,
      blockNumber: blockNumber);
}

class _TaskPageState extends State<TaskPage> {
  _TaskPageState(
      {@required this.subjectId,
      @required this.uuid,
      this.trialNumber,
      this.blockNumber});

  String subjectId;
  String uuid;
  int trialNumber;
  int blockNumber;
  Color squareColor;
  Future<Data> _futureData;
  Map dataMap = {'\"version\"': 1};
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
  int pressCount = 0;
  String majorityChoice;
  String elapsedTime = '0';
  List movesList = [];
  Map pattern = {};
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

  Map createDataList(pattern, totalTime, majorityChoice) {
    dataMap['\"grid\"'] = pattern;
    dataMap['\"total time\"'] = totalTime;
    getCorrectMajority(majorityChoice);
    return dataMap;
  }

  Map createGridMap() {
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
    String result;

    if (majorityChoice == 'yellow') {
      dataMap['\"picked\"'] = '\"yellow\"';
      if (yellowCount > blueCount) {
        dataMap['\"answer\"'] = '\"correct\"';
        result = 'You win!';
        return result;
      } else {
        dataMap['\"answer\"'] = '\"incorrect\"';
        result = 'You lose';
        return result;
      }
    } else if (majorityChoice == 'blue') {
      dataMap['\"picked\"'] = '\"blue\"';
      if (blueCount > yellowCount) {
        dataMap['\"answer\"'] = '\"correct\"';
        result = 'You win!';
        return result;
      } else {
        dataMap['\"answer\"'] = '\"incorrect\"';
        result = 'You lose';
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
    initList();
    getSquareColor();
    movesList.add([
      '\"location\"',
      '\"time\"',
    ]);
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
                    String elapsedTime =
                        stopwatch.elapsedMilliseconds.toString();
                    if (flippedSquares[index] == false && index < 25) {
                      String squareColor;
                      if (gridMap[index] == 1) {
                        squareColor = 'blue';
                      } else if (gridMap[index] == 2) {
                        squareColor = 'yellow';
                      }
                      movesList.add([index, elapsedTime]);
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
                      elapsedTime = stopwatch.elapsedMilliseconds.toString();
                      stopwatch.reset();
                      majorityChoice = 'yellow';
                      Map pattern = createGridMap();
                      String dataString =
                          createDataList(pattern, elapsedTime, majorityChoice)
                              .toString();
                      createData('IST', uuid, dataString, '0.1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                              resultText: getCorrectMajority(majorityChoice)),
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
                      Map pattern = createGridMap();
                      String dataString =
                          createDataList(pattern, elapsedTime, majorityChoice)
                              .toString();
                      createData('IST', uuid, dataString, '0.1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                              resultText: getCorrectMajority(majorityChoice)),
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
