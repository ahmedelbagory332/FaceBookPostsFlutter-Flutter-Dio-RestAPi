import 'package:flutter/material.dart';

import 'package:api_moordb/Screens/LogingScreen.dart';
import 'package:api_moordb/Screens/RegisterScreen.dart';


class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {


     return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text("FaceBook Test",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),)
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25 , right: 25),
                      child: Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 10.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                          },
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .height * .4,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .05
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25 , right: 25),
                      child: Material(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 10.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LogingScreen()));
                          },
                          minWidth: MediaQuery
                              .of(context)
                              .size
                              .height * .4,
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .05
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),


        ),
      );

  }
}
