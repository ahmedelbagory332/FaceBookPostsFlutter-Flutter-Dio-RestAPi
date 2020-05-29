import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:api_moordb/Screens/UploadScreen.dart';

class LogingScreen extends StatefulWidget {
  @override
  _LogingScreenState createState() => _LogingScreenState();
}

class _LogingScreenState extends State<LogingScreen> {
  final emailConroler = TextEditingController();
  final passwordConroler = TextEditingController();

  String email, password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
   bool _show = false;
  Future<int> uploadUser(String email, String password) async {
    int status = 0;

    try {
      FormData formData =
      new FormData.from({"email": email, "pass": password});

      Response response = await Dio().post(
          "http://192.168.1.8/FaceBookPostsFlutter/php/signin.php",
          data: formData);

      var responseServer = jsonDecode(response.data);


      if (responseServer['response'] == 'faild')
        status = 0;
      else
        status = 1;



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

    return Scaffold(
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
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 10.0,
                  child: MaterialButton(
                    onPressed: ()async {
                      setState(() {
                        _show = true;
                      });
                      if (emailConroler.text.isEmpty || passwordConroler.text.isEmpty) {

                        _showSnakBarMsg('Check Your Info.');
                      } else {
                         uploadUser(email,password).then((val) {

                          if (val == 0) {
                            _showSnakBarMsg("login error");
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
                    minWidth: MediaQuery.of(context).size.height * .4,
                    child: Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .05),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
