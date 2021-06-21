import 'package:flutter/material.dart';
import 'instruction_page.dart';
import 'package:uuid/uuid.dart';
import 'fixed_inst.dart';
import 'decreasing_inst.dart';

class SubjectIDPage extends StatefulWidget {
  SubjectIDPage({this.versionNumber});
  final int versionNumber;
  @override
  _SubjectIDPageState createState() =>
      _SubjectIDPageState(versionNumber: versionNumber);
}

class _SubjectIDPageState extends State<SubjectIDPage> {
  _SubjectIDPageState({this.versionNumber});
  int versionNumber;
  var uuid = Uuid();
  String subjectId;
  int trialNumber = 0;
  int blockNumber = 1;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("No subject ID entered"),
      content: Text("Please enter a subject ID before continuing."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                heightFactor: MediaQuery.of(context).size.height * .1,
                child: Text(
                  'Please enter Subject ID:',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Subject ID'),
                onChanged: (value) {
                  subjectId = value;
                },
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.75,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    if (subjectId == null) {
                      showAlertDialog(context);
                    } else {
                      String newId = uuid.v1();
                      if (versionNumber == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FixedWinInst(
                              subjectId: subjectId,
                              uuid: newId,
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
                              uuid: newId,
                              trialNumber: trialNumber,
                              blockNumber: blockNumber,
                              versionNumber: versionNumber,
                            ),
                          ),
                        );
                      }
                    }
                  }),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
          ),
        ],
      ),
    );
  }
}
