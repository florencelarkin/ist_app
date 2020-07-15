import 'package:flutter/material.dart';
import 'task_page.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Sampling Task Instructions'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                'In this task your goal is to figure out whether there is a majority of blue or yellow squares. To reveal the squares in the grid, tap on them. When you are ready to choose which color you think is the majority, press the yellow button for yellow or the blue button for blue.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          FlatButton(
            color: Colors.white,
            child: Text(
              'Click to Begin',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFF0A0E21),
              ),
            ),
            padding: EdgeInsets.all(30.0),
            onPressed: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(),),);
              });
          },
          ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }
}
