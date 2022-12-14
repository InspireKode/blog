import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/New_post.dart';
import 'package:my_first_app/home_page.dart';
import 'package:my_first_app/login_page.dart';
import 'package:my_first_app/profile.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;
  late final PageController _controller = PageController();

  void _setPage(int index) {
    if (currentIndex == index) return;
    setState(() {
      currentIndex = index;
    });
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Blog App'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  color: Colors.red,
                  height: 167,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.only(left: 50.0, right: 40.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30.0,
                ),
                title: Text('Profile'),
                onTap: () {
                  var route =
                      MaterialPageRoute(builder: (BuildContext b) => Profile());
                  Navigator.of(context).push(route);
                },
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.black, size: 30.0),
                title: Text('Settings'),
                onTap: () {},
              ),
            ),
            InkWell(
              child: ListTile(
                leading:
                    Icon(Icons.notifications, color: Colors.black, size: 30.0),
                title: Text('Notification'),
                onTap: () {},
              ),
            ),
            SizedBox(height: 250.0),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.black, size: 30.0),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  var route = MaterialPageRoute(
                      builder: (BuildContext b) => LoginPage());
                  Navigator.of(context).push(route);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: (FloatingActionButtonLocation.centerDocked),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(builder: (BuildContext b) => NewPost());
          Navigator.of(context).push(route);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape:  const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  _setPage(0);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: IconButton(
                icon: Icon(Icons.person),
                color: Colors.black,
                iconSize: 40,
                onPressed: () {
                  _setPage(1);
                },
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (i) {
          currentIndex = i;
          setState(() {});
        },
        children: const [
          HomePage(),
          Profile(),
        ],
      ),
    );
  }
}
