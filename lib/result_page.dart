import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'You Win!',
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
              Navigator.pop(context);
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
