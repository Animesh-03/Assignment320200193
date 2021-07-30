import 'package:flutter/material.dart';

class Track extends StatefulWidget {
  void Function(TextEditingController, String) submit;

  Track({required this.submit});

  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  List<String> assignmentList = ['1', '2', '3', '4', '5'];
  String assignmentValue = '2';

  final Color formFieldsColor = Colors.grey.withOpacity(0.3);
  final Color primaryColor = Color(0xff2FC4B2);

  TextEditingController scoreController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200, left: 15, right: 15),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Assignment",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    child: DropdownButtonFormField(
                      items: assignmentList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: assignmentValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          assignmentValue = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                    color: formFieldsColor,
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800, height: 3),
                  ),
                  TextFormField(
                    controller: scoreController,
                    decoration: InputDecoration(
                        hintText: "Enter Score",
                        fillColor: formFieldsColor,
                        filled: true),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: ElevatedButton(
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        onPressed: () =>
                            widget.submit(scoreController, assignmentValue),
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
