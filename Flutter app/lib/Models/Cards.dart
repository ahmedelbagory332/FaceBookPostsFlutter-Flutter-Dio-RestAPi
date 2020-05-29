import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String post;
  final String time;

  Cards(this.imgUrl, this.name, this.post, this.time);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 20,
        child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8,top: 8 , left: 5,bottom: 8),
                child: SizedBox(
                  height: 100,
                   child: Image.network(imgUrl),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    Text(time,style: TextStyle(
                      fontSize: 12,
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(post,)


                  ],
                ),
              ),

            ],
        )
    );
  }
}
