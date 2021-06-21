import 'package:flutter/material.dart';
import 'task_page.dart';
//import 'task_page_v2.dart';

class FixedWinInst extends StatefulWidget {
  FixedWinInst({
    @required this.subjectId,
    @required this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.versionNumber,
  });
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  final int versionNumber;

  @override
  _FixedWinInstState createState() => _FixedWinInstState(
        subjectId: subjectId,
        uuid: uuid,
        trialNumber: trialNumber,
        blockNumber: blockNumber,
        versionNumber: versionNumber,
      );
}

class _FixedWinInstState extends State<FixedWinInst> {
  _FixedWinInstState({
    @required this.subjectId,
    @required this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.versionNumber,
  });
  String subjectId;
  String uuid;
  int trialNumber;
  int blockNumber = 1;
  int versionNumber;
  int currentPoints = 0;
  int wins = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Sampling Task Instructions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'In this task your goal is to figure out whether there is a majority of blue or yellow squares. To reveal the squares in the grid, tap on them. When you are ready to choose which color you think is the majority, press the yellow button for yellow or the blue button for blue. You can click as many squares as you want without penalty. If you are correct, you will win 100 points and if you are wrong you will lose 100 points.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text(
                  'Begin', //fixed win
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF0A0E21),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    //currentPoints = 0;
                    trialNumber = 1;
                    versionNumber = 1;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(
                          subjectId: subjectId,
                          uuid: uuid,
                          versionNumber: versionNumber,
                          currentPoints: currentPoints,
                          wins: wins,
                          trialNumber: trialNumber,
                          blockNumber: blockNumber,
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
