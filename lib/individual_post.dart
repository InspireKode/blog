import 'package:my_first_app/comment.dart';
import 'package:my_first_app/profile.dart';
import 'New_post.dart';
import 'Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import'constant.dart';

class SingleBlog extends StatefulWidget {

  final Map blog;

  SingleBlog({Key? key, required this.blog}) : super(key: key);

  @override
  State<SingleBlog> createState() => _SingleBlogState();
}

class _SingleBlogState extends State<SingleBlog> {

bool isLiked = false;
// final likers = List<String>.from(blog['likers']);
//                 if (likers.contains(currentUser.id)){
//                                return IconButton(Icon(Icons.thumb_up))
//                                   }else {
//                                     return IconButton(Icon(Icons.thumb_down))
//                                   }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var route = MaterialPageRoute(
            builder: (BuildContext) =>
                Details(blog: widget.blog));
        Navigator.push(context, route);
      },
      child: Container(
        //height: 350,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child: Column(
                    children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.blog['title'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Author : " + widget.blog['author'],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    loadImage(
                      url: widget.blog['imageurl'],
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 3),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: widget.blog['content'].length > 30
                          ? Text(widget.blog['content']
                                  .toString()
                                  .substring(0, 150) +
                              "")
                          : Text(widget.blog['content']),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                     IconButton(
                                icon: Icon(
                                    isLiked
                                        ? Icons.thumb_up
                                        : Icons.thumb_down,
                                    color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    isLiked = !isLiked;
                                  });
                                  // final likers = List<String>.from(blog['likers'])
                                  // if (likers.contains(currentUser.id)){
                                  //   likers.remove(currentUser.id)
                                  //   FirebaseFirestore.instance.collection('blog').doc(blog['id']).set('likers': likers);
                                  // } else {
                                  //     likers.add(currentUser.id)
                                  //     FirebaseFirestore.instance.collection('blog').doc(blog['id']).set('likers': likers);
                                  // }

                                },
                              ),
                              IconButton(
                                onPressed: (){
                                  var route =
                      MaterialPageRoute(builder: (BuildContext b) => CommmentPage());
                  Navigator.of(context).push(route);
                                }, 
                                icon: Icon(Icons.comment,
                                color: Colors.black,
                                ))
                        ]
                      )
                    
                      )
                    
                        ]),
                    ),

                  ]),
                ),
              
            ),
        
      
      ),
    );
  }
  }
