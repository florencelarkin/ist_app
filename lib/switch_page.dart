import 'package:flutter/material.dart';
import 'fixed_inst.dart';
import 'decreasing_inst.dart';

class BlockPage extends StatefulWidget {
  BlockPage({
    @required this.subjectId,
    @required this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.wins,
    this.versionNumber,
    this.currentPoints,
  });
  final String subjectId;
  final String uuid;
  final int trialNumber;
  final int blockNumber;
  final int wins;
  final int versionNumber;
  final int currentPoints;

  @override
  _BlockPageState createState() => _BlockPageState(
        subjectId: subjectId,
        uuid: uuid,
        trialNumber: trialNumber,
        blockNumber: blockNumber,
        wins: wins,
        versionNumber: versionNumber,
        currentPoints: currentPoints,
      );
}

class _BlockPageState extends State<BlockPage> {
  _BlockPageState({
    @required this.subjectId,
    @required this.uuid,
    this.trialNumber,
    this.blockNumber,
    this.wins,
    this.versionNumber,
    this.currentPoints,
  });
  String subjectId;
  double maxVelocity;
  String uuid;
  int trialNumber;
  int blockNumber;
  int wins;
  int versionNumber;
  int currentPoints;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'You have completed the first block of trials',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'The next 10 trials will switch conditions and your points will reset to zero.',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Click \"start\" to begin the next block.',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ElevatedButton(
            child: Text('START'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              blockNumber++;
              currentPoints = 0;
              if (versionNumber == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FixedWinInst(
                      subjectId: subjectId,
                      uuid: uuid,
                      trialNumber: trialNumber,
                      blockNumber: blockNumber,
                      versionNumber: versionNumber,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DecreasingWinInst(
                      subjectId: subjectId,
                      uuid: uuid,
                      trialNumber: trialNumber,
                      blockNumber: blockNumber,
                      versionNumber: versionNumber,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
