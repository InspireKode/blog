import 'dart:io';

import 'authentication.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  ImagePicker picker = ImagePicker();
  var _image;
  File? imagefile;
  XFile? xFile;
  void pickImage() async {
    xFile = await picker.pickImage(source: ImageSource.gallery);
    _image = File(xFile!.path);
    imagefile = _image;
    setState(() {});
  }

  var titleCtr = TextEditingController();
  var contentCtr = TextEditingController();
  var authorCtr = TextEditingController();
  var imageUrl = "";
  var error_msg = "";
  bool isposting = false;
  Future<bool> goToHome() async {
    var route = MaterialPageRoute(builder: (BuildContext) => HomePage());
    Navigator.push(context, route);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            goToHome();
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => goToHome(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Blog Title"),
                  controller: titleCtr,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Author"),
                  controller: authorCtr,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  controller: contentCtr,
                  maxLines: 5,
                  minLines: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                    margin: EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      radius: 80.0,
                      child: new IconButton(
                              icon: Icon(Icons.add_a_photo, 
                              size: 70.0,
                              color: Colors.white,
                              ),
                              onPressed: (){
                                pickImage();
                              },
                            ),
                    )
                        
                
                ),
                SizedBox(
                  height: 5,
                ),
                error_msg != ''
                    ? Container(
                        child: Text(
                          error_msg,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container(),
                Visibility(
                  visible: isposting,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        error_msg = "";
                      });
                      if (titleCtr.text.length < 10) {
                        error_msg = "Title must be greater than 10 chaN racters";
                      } else if (contentCtr.text.trim().length < 10) {
                        error_msg =
                            "Content must be greater than 10 characters";
                      } else if (imagefile == null) {
                        error_msg = "Please select an Image";
                      }
                      if (authorCtr.text.length < 2) {
                        error_msg = "author name too short";
                      } else {
                        // uploadToFirebaseStorage();
                      }
                      setState(() {});
                    },
                    child: Text("Submit Blog"),
                    textColor: Colors.white,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      goToHome();
                    },
                    child: Text("Cancel"))
              ],
            )),
          ),
        ),
      ),
    );
  }

  void uploadToFirebaseStorage() async {
    isposting = true;
    setState(() {});
    FirebaseStorage storage = FirebaseStorage.instance;
    //
    var reference = storage.ref().child("blog_images");

    var uploadTask =
        reference.child(imagefile!.path.split('/').last).putFile(imagefile!);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();

    submitPost();

    // print(imageUrl);
  }

  void submitPost() {
    var blog_ref = FirebaseFirestore.instance.collection("blog");
    blog_ref.add({
      'title': titleCtr.text,
      'content': contentCtr.text,
      'imageurl': imageUrl,
      'author': authorCtr.text,
      'user_id': FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      setState(() {
        isposting = false;
        titleCtr.text = '';
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Successfull")));
    }).catchError((error) => print("Failed to add: $error"));
  }
  
}
