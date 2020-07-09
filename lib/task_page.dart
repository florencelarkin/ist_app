import 'package:flutter/material.dart';
import 'constants.dart';
import 'result_page.dart';
import 'grid_square.dart';
import 'dart:math';

String getRandomNumber () {
  int randomNumber = Random().nextInt(2);

  return randomNumber.toString();
}

enum Activated {
  on,
  off,
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  Activated activated = Activated.off;
  Color squareColor;


  List<String> colorKeys = ['y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y','y',];


  int selectedIndex = 0;
  int yellowCount = 0;
  int blueCount = 0;

  onSelected (int index) {
    setState(() => selectedIndex = index);
  }

  Color getSquareColor () {
    int randomNumber = Random().nextInt(2);
    if (randomNumber == 0) {
      squareColor = Colors.yellow;
      yellowCount++;
      activated = Activated.on;
      return squareColor;
    }
    else  {
      squareColor = Colors.blue;
      blueCount++;
      activated = Activated.on;
      return squareColor;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: GridView.builder(
        itemCount: colorKeys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5),
        itemBuilder: (context, index) => GridSquare(
          color: selectedIndex != null && selectedIndex == index && activated == Activated.on ? getSquareColor() : kUnpressedColor,
          onPress: () {
            setState(() {
              onSelected(index);
            },);
          },
        ),
      ),



    );/*Column(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Expanded(
          child: GridView.count(
        crossAxisCount: 5,
        children: colorKeys.map((String colorCode) {
          return GridTile(
            child: GridSquare(
              onPress: (){
                setState(() {
                  for(int i = 0; i < colorKeys.length; i++){
                    if(i == 1){
                      activated = Activated.on;
                      print('this worked');
                    }
                    else {
                      activated = Activated.off;
                      print('this didnt work');}
                  }
                });
                },
              color: activated == Activated.on ? kPressedColor : kUnpressedColor,
    ),);
    }).toList()),
    ),

        FlatButton(
          child: Text(''),
          padding: const EdgeInsets.only(left: double.infinity, right: double.infinity, top: 40.0, ),
          color: Colors.yellow,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),
            ),
            );
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        FlatButton(
          child: Text(''),
          padding: const EdgeInsets.only(left: double.infinity, right: double.infinity, top: 40.0),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(),
            ),
            );
          },
        ),
        SizedBox(
          height: 40.0,
        ),
    ],
    );*/
  }
}
