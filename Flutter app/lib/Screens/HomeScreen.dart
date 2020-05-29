import 'dart:convert';

import 'package:api_moordb/Models/Cards.dart';
import 'package:api_moordb/Models/PostModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostModel> _list = [];

  Response response;
  void getPosts() async {
    response = await Dio()
        .get("http://192.168.1.8/FaceBookPostsFlutter/php/getPosts.php");

    final data = jsonDecode(response.data);
    _list.clear();
    setState(() {
      for (var i in data) {
        _list.add(PostModel.fromJson(i));
      }
    });
  }



  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _list.isEmpty
            ? Center(
                child: SpinKitCircle(
                color: Colors.black,
                size: 100.0,
              ))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Cards(_list[index].image, _list[index].name,
                      _list[index].post, _list[index].time);
                },
              ),
      ),
    );
  }
}
