import 'package:flutter/material.dart';
import 'package:my_first_app/home_page.dart';
import 'Sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailCTR = TextEditingController();
  var passwordCTR = TextEditingController();
  var error_msg = "";

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        // appBar: AppBar(
        //   title: Text('Flutter Blog App'),
        // ),

        body: Center(
          child: SingleChildScrollView(
              child: Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: const Text(
                    'WELCOME BACK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(
                    child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 100,
                  ),
                )),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(20),
                  width: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (email) => (email?.isEmpty ?? true)
                              ? 'Please provide email'
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: "Email",
                              hintText: 'Enter your email here',
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.black)),
                          controller: emailCTR,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (pwd) => (pwd?.isEmpty ?? true)
                              ? 'Please provide your password'
                              : null,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelText: "Password",
                              hintText: 'Enter your password here',
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
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
                        error_msg != ''
                            ? Text(
                                error_msg,
                                style: const TextStyle(color: Colors.red),
                              )
                            : Container(),
                        const SizedBox(height: 10.0),
                        MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // var route = MaterialPageRoute(
                              //     builder: (BuildContext) => HomePage());
                              // Navigator.push(context, route);
                              // setState(() {
                              //   //error_msg = "";
                              // });
                              signIn();
                            }
                          },
                          // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2000),
                          textColor: Colors.white,
                          color: Colors.red,
                          child: const SizedBox(child: const Center(child: const Text("Sign In")), height: 20, width: 200),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                var route = MaterialPageRoute(
                                    builder: (context) => const SignUp());
                                Navigator.push(context, route);
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]))),
        ));
  }

  void signIn() async {
    try {
      getUsername();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailCTR.text, password: passwordCTR.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        error_msg = e.code;
        print(error_msg);
      });
    }
  }

  void getUsername() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // print("user is currently not signed in");
      } else {

        Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));

        // FirebaseFirestore.instance
        //     .collection('user')
        //     .doc(user.uid)
        //     .get()
        //     .then((querySnapshot) {
        //   var details = querySnapshot.data();
        //   // UserModel.uid= details!['username'];
        //   print('logging in');
        //   Navigator.of(context)
        //       .push(MaterialPageRoute(builder: (context) => const HomePage()));
        // }).catchError((e) {
        //   print(e);
        // });
      }
    });
  }
}
