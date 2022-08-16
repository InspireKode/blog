import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

class Details extends StatefulWidget {
  final Map blog;

  Details({Key? key, required this.blog}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: loadImage(
                url: widget.blog['imageurl'],
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                widget.blog['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                widget.blog['content'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
