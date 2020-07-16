import 'package:flutter/material.dart';
import 'package:istapp/task_page.dart';

class ResultPage extends StatelessWidget {
  ResultPage({@required this.resultText});

  final String resultText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Points: '),),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(),),);
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
