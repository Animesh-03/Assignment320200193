import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  createState() => RegisterPageState();
}

enum Excited { Yes, No }

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Color primaryColor = Color(0xff2FC4B2);
  final Color formFieldsColor = Colors.grey.withOpacity(0.3);

  final List<String> batchList = ['2016', '2017', '2018', '2019', '2020'];
  String batchListValue = '2020';

  bool updateSwtichvalue = false;

  Excited? radio = Excited.Yes;

  TextEditingController idController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  void storeStrings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("UserID", idController.text);
    prefs.setString("UserName", nameController.text);
    prefs.setBool("LoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CRUX FLUTTER SUMMER GROUP",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ID Number",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                      TextFormField(
                        controller: idController,
                        decoration: InputDecoration(
                            hintText: "Please Enter Your Student ID",
                            fillColor: formFieldsColor,
                            filled: true),
                      ),
                      Text(
                        "User Name",
                        style: TextStyle(
                            fontSize: 15,
                            height: 3,
                            fontWeight: FontWeight.w800),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Please Enter Your User Name",
                            fillColor: formFieldsColor,
                            filled: true),
                      ),
                      Text("Password",
                          style: TextStyle(
                              fontSize: 15,
                              height: 3,
                              fontWeight: FontWeight.w800)),
                      TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter Your Password",
                              fillColor: formFieldsColor,
                              filled: true)),
                      Text("Batch",
                          style: TextStyle(
                              fontSize: 15,
                              height: 3,
                              fontWeight: FontWeight.w800)),
                      Container(
                        child: DropdownButtonFormField(
                          items: batchList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          //value: batchListValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              batchListValue = newValue!;
                            });
                          },
                          hint: Text(batchListValue),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10)),
                        ),
                        color: formFieldsColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recieve Regular Updates",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800)),
                            Switch(
                              value: updateSwtichvalue,
                              onChanged: (bool newValue) {
                                setState(() {
                                  updateSwtichvalue = newValue;
                                });
                              },
                              activeColor: primaryColor,
                              inactiveTrackColor: formFieldsColor,
                              inactiveThumbColor: primaryColor,
                            )
                          ],
                        ),
                      ),
                      Text("Are You Excited For This?!!",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800)),
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(right: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                  activeColor: primaryColor,
                                  value: Excited.Yes,
                                  groupValue: radio,
                                  onChanged: (Excited? newValue) {
                                    setState(() {
                                      radio = newValue;
                                    });
                                  }),
                              Text("Yes"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Radio(
                                activeColor: primaryColor,
                                value: Excited.No,
                                groupValue: radio,
                                onChanged: (Excited? newValue) {
                                  setState(() {
                                    radio = newValue;
                                  });
                                }),
                            Text("No"),
                          ],
                        )
                      ]),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: ElevatedButton(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                elevation: 2,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 110)),
                            onPressed: () {
                              storeStrings();
                              Navigator.pushNamed(context, '/dashboard');
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already Have an Account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 18),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
