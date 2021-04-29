import 'package:flutter/material.dart';
import 'package:istapp/task_page.dart';

class ResultPage extends StatefulWidget {
  ResultPage({
    @required this.resultText,
    this.wins,
    this.subjectId,
    this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.versionNumber,
    this.currentPoints,
  });

  final String resultText;
  final int wins;
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  final int versionNumber;
  final int currentPoints;

  @override
  _ResultPageState createState() => _ResultPageState(
      subjectId: subjectId,
      uuid: uuid,
      trialNumber: trialNumber,
      resultText: resultText,
      wins: wins,
      versionNumber: versionNumber,
      blockNumber: blockNumber,
      currentPoints: currentPoints);
}

class _ResultPageState extends State<ResultPage> {
  _ResultPageState({
    @required this.resultText,
    this.wins,
    this.subjectId,
    this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.versionNumber,
    this.currentPoints,
  });

  String resultText;
  int wins;
  String subjectId;
  String uuid;
  int trialNumber;
  int blockNumber;
  int versionNumber;
  int currentPoints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                widget.resultText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'Points: $currentPoints',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'NEXT TRIAL',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFF0A0E21),
              ),
            ),
            onPressed: () {
              trialNumber++;
              if (trialNumber == 11) {
                versionNumber == 1
                    ? versionNumber = 2
                    : versionNumber =
                        1; //switch versions to opposite condition for next 10 trials
                versionNumber == 1
                    ? currentPoints = 0
                    : currentPoints =
                        250; //reset points to 0 for fw and 250 for dw
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(
                      versionNumber: versionNumber,
                      subjectId: subjectId,
                      blockNumber: blockNumber,
                      trialNumber: trialNumber,
                      uuid: uuid,
                      currentPoints: currentPoints,
                      wins: wins,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskPage(
                      versionNumber: versionNumber,
                      subjectId: subjectId,
                      blockNumber: blockNumber,
                      trialNumber: trialNumber,
                      uuid: uuid,
                      currentPoints: currentPoints,
                      wins: wins,
                    ),
                  ),
                );
              } //add subject id and version
            },
          ),
          SizedBox(
            height: 150.0,
          ),
        ],
      ),
    );
  }
}
