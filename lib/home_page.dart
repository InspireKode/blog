import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("blog")
            .snapshots()
            .map((event) => List<Map>.from(event.docs.map((e) => e.data()))),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          final blogs = snapshot.data as List<Map>;

          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(blogs[index]["title"]),
              );
            },
          );
        },
      ),
    );
  }
}
