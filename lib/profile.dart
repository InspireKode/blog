import 'package:my_first_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: FirebaseAuth.instance.currentUser == null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text("Please sign in to see your profile"),
                    ),
                  )
                : Center(
                    // padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const  SizedBox(height: 20.0),
                       const  CircleAvatar(
                        radius: 70,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 100,
                  ),

                       ),
                   const    SizedBox(height: 10.0),
                        Text("Email:" + currentUser!.email!)
                      ],
                    ),
                  )),
      ),
    );
  }
}
