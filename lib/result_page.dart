import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'You Win!',
              ),
            ),
          ),
          FlatButton(
            child: Text('RESTART'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
