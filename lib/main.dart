import 'dart:async';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const BlogApp());
}
class BlogApp extends StatelessWidget {
  
  const BlogApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
     Timer(
        Duration(
          seconds: 3,
        ), () {
      var route = MaterialPageRoute(builder: (BuildContext) => LoginPage());
      Navigator.push(context, route);
    });
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png', 
              
              height: 100.0,),
            SizedBox(height: 5),
            Text('Blog App',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text('Credit: Anyadike Emmanuel', style: TextStyle(fontSize: 15))
          ],
        )
      ),
      
    );
  }
}
