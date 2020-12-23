import 'package:flutter/material.dart';
import 'task_page.dart';
import 'task_page_v2.dart';

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
                'In this task your goal is to figure out whether there is a majority of blue or yellow squares. To reveal the squares in the grid, tap on them. When you are ready to choose which color you think is the majority, press the yellow button for yellow or the blue button for blue. In version 1, you can click as many squares as you want without penalty. In version 2, your points decreases for each square you click.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                color: Colors.white,
                child: Text(
                  'Version 1',
                  style: TextStyle(
                    fontSize: 20.0,
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
              ElevatedButton(
                color: Colors.white,
                child: Text(
                  'Version 2',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF0A0E21),
                  ),
                ),
                padding: EdgeInsets.all(30.0),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPagev2(),),);
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
