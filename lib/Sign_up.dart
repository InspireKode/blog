import 'package:flutter/material.dart';
import 'package:my_first_app/home_page.dart';
import 'package:my_first_app/login_page.dart';
import 'package:my_first_app/authentication.dart';
import 'firebase_options.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var usernameCTR = TextEditingController();
  var emailCTR = TextEditingController();
  var passwordCTR = TextEditingController();
  var error_msg = "";

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
        body: SingleChildScrollView(
            child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
      Container(
        margin: EdgeInsets.only(top: 50),
        child: Text(
          'CREATE ACCOUNT',
          style: TextStyle(
              fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          size: 100,
          color: Colors.red,
        ),
      )),
      SizedBox(height: 20,),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.all(10.0),
        width: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  validator: (username) {
                    if (username?.isEmpty ?? true) {
                      return 'Please provide username';
                    }
                    if (usernameCTR.text.length < 3) {
                      return 'username must be at least 3 characters';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      labelText: "Username",
                      hintText: 'Enter your peferred username here',
                      prefixIcon: Icon(Icons.person, color: Colors.black)),
                  controller: usernameCTR,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (email) {
                    if (email?.isEmpty ?? true) {
                      return 'Please provide email';
                    }
                    if (emailCTR.text.length < 5) {
                      return 'Email too short';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      labelText: "Email",
                      hintText: 'Enter your email here',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                  controller: emailCTR,
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (pwsd) {
                    if (pwsd?.isEmpty ?? true) {
                      return 'Please provide password';
                    }
                    if (passwordCTR.text.length < 8) {
                      return 'Password too weak';
                    }
                  },
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      labelText: "Password",
                      hintText: 'Enter your password here',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                            showPassword
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: Colors.black),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )),
                  controller: passwordCTR,
                ),
                SizedBox(height: 10.0),
                MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        //error_msg = "";

                        signUp();
                      }
                    },
                    child: Text("Sign Up"),
                    textColor: Colors.white,
                    color: Colors.red),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        var route = MaterialPageRoute(
                            builder: (BuildContext) => LoginPage());
                        Navigator.push(context, route);
                      },
                      child: Text(
                        "Sign In here",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]))));
  }

  void signUp() async {
    // if (usernameCTR.text.length < 2) {
    //   setState(() {
    //     error_msg = "Username too short";
    //   });
    // } else if (emailCTR.text.length < 3) {
    //   setState(() {
    //     error_msg = "Invalid email";
    //   });
    // } else if (passwordCTR.text.length < 5) {
    //   setState(() {
    //     error_msg = "Password must be greater than 5 characters";
    //   });
    // } else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailCTR.text, password: passwordCTR.text);

      var user = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid);
      user.set({
        "email": emailCTR.text,
        "username": usernameCTR.text,
        "password": passwordCTR.text,
        "id": userCredential.user!.uid,
      });
      //userModel!.username = usernameCTR.text;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext) => HomePage()));
    } on FirebaseException catch (e) {
      setState(() {
        // error_msg = e.code;
      });
    } catch (e) {
      print(e);
    }
  }
}
