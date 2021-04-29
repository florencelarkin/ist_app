import 'package:flutter/material.dart';
import 'id_page.dart';
import 'url_args.dart';

void main() => runApp(IST());

Map<String, String> urlArgs = {};
String subjectID = 'abc123';
int versionNumber = 1;
String defaultTitle = 'test page';

class IST extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: SubjectIDPage(
        versionNumber: versionNumber,
      ),
      onGenerateRoute: (settings) {
        print("settings.name " + settings.name);

        urlArgs = getURLArgs(settings.name);
        urlArgs.forEach((key, value) => print('${key}: ${value}'));

        if (urlArgs.containsKey('version')) {
          versionNumber = int.parse(urlArgs['version']);
        }
        /*if (urlArgs.containsKey('id')) {
          subjectID = urlArgs['id'];
        }*/

        // check for /?id=1234&time=2.0
        switch (settings.name[1]) {
          case '?':
            return MaterialPageRoute(
              builder: (context) => SubjectIDPage(
                versionNumber: versionNumber,
              ),
            );
            break;
          default:
            return MaterialPageRoute(
              builder: (context) => SubjectIDPage(
                versionNumber: 1,
              ),
            );
        }
      },
    );
  }
}
/*
class IST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: SubjectIDPage(),
    );
  }
}*/
