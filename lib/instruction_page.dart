import 'package:flutter/material.dart';
import 'task_page.dart';
//import 'task_page_v2.dart';

class Instructions extends StatefulWidget {
  Instructions(
      {@required this.subjectId,
      @required this.uuid,
      this.trialNumber,
      this.blockNumber, this.versionNumber,});
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  final int versionNumber;

  @override
  _InstructionsState createState() => _InstructionsState(
      subjectId: subjectId,
      uuid: uuid,
      trialNumber: trialNumber,
      blockNumber: blockNumber, versionNumber: versionNumber,);
}

class _InstructionsState extends State<Instructions> {
  _InstructionsState({
    @required this.subjectId,
    @required this.uuid,
    this.trialNumber,
    this.blockNumber, this.versionNumber,
  });
  String subjectId;
  String uuid;
  int trialNumber;
  int blockNumber = 1;
  int versionNumber;
  int currentPoints;
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
                'In this task your goal is to figure out whether there is a majority of blue or yellow squares. To reveal the squares in the grid, tap on them. When you are ready to choose which color you think is the majority, press the yellow button for yellow or the blue button for blue. In version 1, you can click as many squares as you want without penalty. In version 2, your points decreases for each square you click.',
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
                  'Fixed Win',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF0A0E21),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    currentPoints = 0;
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text(
                  'Decreasing Win',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF0A0E21),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    currentPoints = 250;
                    trialNumber = 1;
                    versionNumber = 2;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(
                          subjectId: subjectId,
                          uuid: uuid,
                          versionNumber: versionNumber,
                          trialNumber: trialNumber,
                          blockNumber: blockNumber,
                          currentPoints: currentPoints,
                          wins: wins,
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
