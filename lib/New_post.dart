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
    error_msg = "";

    setState(() {});
  }

  var titleCtr = TextEditingController(text: "Some random title");
  var contentCtr = TextEditingController(text: "Some random blog I'm making");
  var authorCtr = TextEditingController(text: "Lucky");
  final formKey = GlobalKey<FormState>();
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
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Blog Title"),
                      controller: titleCtr,
                      validator: (value) {
                        if (value!.length < 10) {
                          return "Title must be greater than 10 chaN racters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Author"),
                      controller: authorCtr,
                      validator: (value) {
                        if (value!.length < 2) {
                          return "author name too short";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Description"),
                      controller: contentCtr,
                      maxLines: 5,
                      minLines: 5,
                      validator: (value) {
                        if (value!.trim().length < 10) {
                          return "Content must be greater than 10 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ignore: sized_box_for_whitespace
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          radius: 80.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              pickImage();
                            },
                          ),
                        )),
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
                          if (formKey.currentState!.validate()) {
                            if (imagefile == null) {
                              error_msg = "Please select an Image";
                              setState(() {});
                              return;
                            }

                            uploadToFirebaseStorage();
                          }
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
    try {
      isposting = true;
      setState(() {});
      FirebaseStorage storage = FirebaseStorage.instance;
      //
      var reference = storage.ref().child("blog_images");

      var uploadTask =
          reference.child(imagefile!.path.split('/').last).putFile(imagefile!);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();

      await submitPost();
    } catch (e) {
      isposting = false;
      setState(() {});
      print(e);
    }
  }

  Future<void> submitPost() async {
    try {
      var blog_ref = FirebaseFirestore.instance.collection("blog");
      await blog_ref.add({
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
    } catch (e, trace) {
      isposting = false;
      setState(() {});
      print(e);
      print(trace);
    }
  }
}
