import 'package:assignment320200193/bottomNavBar.dart';
import 'package:assignment320200193/home.dart';
import 'package:assignment320200193/homeVariables.dart';
import 'package:assignment320200193/settings.dart';
import 'package:assignment320200193/track.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String userID;
  final String userName;

  Dashboard({required this.userID, required this.userName});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentDashboardIndex = 1;

  List<int> scores = [-10, -10, -10, -10, -10];
  int totalScore = 0;
  int asnsDone = 0;

  void storeHomeVariables() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Score", totalScore);
    prefs.setInt("AssignmnetsDone", asnsDone);
  }

  @override
  Widget build(BuildContext context) {
    Home home = new Home(
        userID: widget.userID,
        userName: widget.userName,
        updateState: (HomeVariables vars) {
          setState(() {
            vars.assignmentsDone = asnsDone;
            vars.score = totalScore;
            storeHomeVariables();
          });
        });

    Track track = new Track(
      //Submit updates all the variables required for Home class
      submit: (TextEditingController scoreController, String assignmentNum) {
        //Updates the scores list according to the assignment number selected in Track() class
        scores[int.parse(assignmentNum) - 1] = int.parse(scoreController.text);
        //Clears the "Score" formField
        scoreController.clear();

        asnsDone = 0;
        totalScore = 0;
        for (int i = 0; i < 5; i++) {
          //updates totalScore and number of assignments done
          if (scores[i] > -10) {
            totalScore += scores[i];
            asnsDone++;
          }
        }
      },
    );

    Settings settings = new Settings();

    List<Widget> navBarItems = [track, home, settings];
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
          initialIndex: 1,
          onIndexChanged: (int index) {
            setState(() {
              currentDashboardIndex = index;
            });
          }),
      body: navBarItems.elementAt(currentDashboardIndex),
    );
  }
}
