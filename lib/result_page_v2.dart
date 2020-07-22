import 'package:flutter/material.dart';
import 'package:istapp/task_page_v2.dart';

class ResultPagev2 extends StatelessWidget {
  ResultPagev2({@required this.resultText, this.points});

  final String resultText;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Points: $points'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                resultText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
            ),
          ),
          FlatButton(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 50.0, right: 50.0),
            child: Text(
              'RESTART',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFF0A0E21),
              ),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPagev2(),),);
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
