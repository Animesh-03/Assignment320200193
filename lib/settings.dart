import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

enum DisplayStyle { ID, Name }

class _SettingsState extends State<Settings> {
  DisplayStyle? displayStyle = DisplayStyle.ID;

  void displayName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("DisplayStyle", displayStyle as int);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 40,
          ),
          child: Text("Choose Display Style",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
        ),
        Row(children: [
          Padding(
            padding: EdgeInsets.only(
              right: 5,
              left: 5,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 120),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: DisplayStyle.ID,
                        groupValue: displayStyle,
                        onChanged: (DisplayStyle? newValue) {
                          setState(() {
                            displayStyle = newValue;
                          });
                          displayName();
                        },
                      ),
                      Text("ID Number")
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Radio(
                        value: DisplayStyle.Name,
                        groupValue: displayStyle,
                        onChanged: (DisplayStyle? newValue) {
                          setState(() {
                            displayStyle = newValue;
                          });
                          displayName();
                        }),
                    Text("Name")
                  ],
                ),
              ],
            ),
          )
        ])
      ],
    );
  }
}
