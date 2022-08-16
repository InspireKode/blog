import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/foundation/key.dart';

import 'individual_post.dart';
import 'package:flutter/material.dart';

class CommmentPage extends StatefulWidget {
  const CommmentPage({Key? key}) : super(key: key);

  @override
  State<CommmentPage> createState() => _CommmentPageState();
}

class _CommmentPageState extends State<CommmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
     padding: const EdgeInsets.all(20.0),
     margin: const EdgeInsets.all(10.0),
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                labelText: "Comments",
                hintText: 'Write a comment'),
            maxLength: 400,
            minLines: 5,
            maxLines: 5,
          ),
          MaterialButton(
            color: Colors.red,
            onPressed: () {},
            child: Text('Post Comment'),
            )
        ],
      )),
    );
  }
}
