import 'package:assignment320200193/homeVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String userID;
  final String userName;
  Function(HomeVariables) updateState;

  Home(
      {required this.userID,
      required this.userName,
      required this.updateState});

  @override
  _HomeState createState() => _HomeState();
}

SharedPreferences? prefs;

class _HomeState extends State<Home> {
  final Color primaryColor = Color(0xff2FC4B2);
  final int assignmentCount = 5;

  HomeVariables variables = new HomeVariables();

  void initializeVariables(HomeVariables vars) async {
    prefs = await SharedPreferences.getInstance();

    if (prefs?.getInt("AssignmentsDone") != null)
      vars.assignmentsDone = prefs?.getInt("AssignmentsDone") as int;
    if (prefs?.getInt("Score") != null)
      vars.score = prefs?.getInt("Score") as int;
  }

  @override
  void initState() {
    super.initState();
    initializeVariables(variables);
  }

  @override
  Widget build(BuildContext context) {
    String displayName =
        (prefs?.getInt("DisplayStyle") == 0) ? widget.userID : widget.userName;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi $displayName ! ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(""),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        "Your Progress",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${variables.assignmentsDone} / $assignmentCount",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("Assignments Done",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Text(
                                    "${((variables.assignmentsDone / assignmentCount)) * 100}%",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Your Score",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("${variables.score}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 60),
                child: ElevatedButton(
                  child: Text(
                    "RELOAD",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  onPressed: () {
                    widget.updateState(variables);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
