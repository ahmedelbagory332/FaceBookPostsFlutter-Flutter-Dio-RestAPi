import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:api_moordb/Screens/UploadScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameConroler = TextEditingController();
  final emailConroler = TextEditingController();
  final passwordConroler = TextEditingController();

  String name, email, password;
  bool _show = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  Future<int> uploadUser(String name, String email, String password) async {
    int status = 0;
    try {
      FormData formData =
          new FormData.from({"name": name, "email": email, "pass": password});

      Response response = await Dio().post(
          "http://192.168.1.8/FaceBookPostsFlutter/php/signup.php",
          data: formData);

      var responseServer = jsonDecode(response.data);

      if (responseServer['response'] == 'exists')
        status = 0;
      else if (responseServer['response'] == 'error')
        status = 1;
      else
        status = 2;
    } catch (e) {
      print("Exception Caught : $e");
    }

    return status;
  }

  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Loading...',
    );
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                _show?SpinKitRing(
                  color: Colors.black,
                  size: 100.0,
                ):Container(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03,
                      vertical: MediaQuery.of(context).size.width * .03),
                  child: TextField(
                    controller: nameConroler,
                       onChanged: (val) {
                      name = val;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.cyan,
                            width: MediaQuery.of(context).size.width * .003),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(

                    controller: emailConroler,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      email = val;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',

                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.cyan,
                            width: MediaQuery.of(context).size.width * .003),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(

                    controller: passwordConroler,
                    obscureText: true,
                    onChanged: (val) {
                      password = val;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Enter your passowrd',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.cyan,
                            width: MediaQuery.of(context).size.width * .003),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 10.0,
                    child: Builder(builder: (BuildContext context) {
                      return MaterialButton(
                        onPressed: () async {

                           setState(() {
                             _show = true;
                           });

                          if (nameConroler.text.isEmpty ||
                              emailConroler.text.isEmpty ||
                              passwordConroler.text.isEmpty) {
                            _showSnakBarMsg("Check Your Info.");
                          } else {
                             uploadUser(name, email, password).then((val) {

                              if (val == 0) {
                                _showSnakBarMsg("The current user exists");
                                setState(() {
                                  _show = false;
                                });
                               } else if (val == 1) {
                                _showSnakBarMsg("Something went wrong");
                                setState(() {
                                  _show = false;
                                });
                               } else {
                                Navigator.pushNamed(context, 'UploadScreen');
                                setState(() {
                                  _show = false;
                                });
                               }


                            });
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .05),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
