import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:api_moordb/Screens/HomeScreen.dart';


class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File _image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameConroler = TextEditingController();
  final postConroler = TextEditingController();
  String name , post;
  ProgressDialog pr;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }


  void _uploadFile(filePath , name , post , time) async {
    // Get base file name
    String fileName = basename(filePath.path);
    print("File base name: $fileName");

    try {
      FormData formData =
      new FormData.from({"image_path": new UploadFileInfo(filePath, fileName),"name":name,"post":post,"time":time});

      Response response =
      await Dio().post("http://192.168.1.8/FaceBookPostsFlutter/php/uploadpost.php", data: formData);

      var responseServer = jsonDecode(response.data);


      _showSnakBarMsg(responseServer[0]['message']);
    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  // Method for showing snak bar message
  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
    pr.hide();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(
        message: 'Uploading...',
    );
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Upload Post'),
          actions: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                icon: Icon(Icons.home,color: Colors.black,)
            )
          ],
        ),
          body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
                child: Container(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  controller: postConroler,
                  onChanged: (val) {
                    post = val;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Enter your post',
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: getImage,
                      child: Text(
                        "Choose Photo",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: ()async {
                        if(postConroler.text.isEmpty || nameConroler.text.isEmpty ||  _image == null)
                          {
                            _showSnakBarMsg("Check Your Info.");

                          }
                          else
                            {
                              await pr.show();
                              DateTime startDate = await NTP.now();
                              String timeCreation = DateFormat("dd-MM-yyyy hh:mm aaa").format(startDate);
                              _uploadFile(_image, name, post, timeCreation);


                            }
                      },
                      child: Text(
                        "Upload Post",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
