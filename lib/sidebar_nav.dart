import 'package:agil_elibrary/downloads.dart';
import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'home_page.dart';
import 'signin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SideBarNav extends StatefulWidget {
  @override
  _SideBarNavState createState() => _SideBarNavState();
}

class _SideBarNavState extends State<SideBarNav> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String? _imageUrl;


  Future<void> _fetchUserImageUrl() async {
    final user = _auth.currentUser;

    if (user != null) {
      DatabaseEvent event = await _database.child('users/${user.uid}').once();
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data['imageUrl'] != null) {
        setState(() {
          _imageUrl = data['imageUrl'];
        });
        print('Fetched image URL: $_imageUrl');
      } else {
        setState(() {
          _imageUrl = null;
        });
      }
    } else {
      setState(() {
        _imageUrl = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: user != null ? Text(user.email ?? '') : Text('No email'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage: _imageUrl != null ? NetworkImage(_imageUrl!) : null,
              child: _imageUrl == null
                  ? Icon(Icons.account_circle, color: Colors.white)
                  : null,
            ),
            decoration: BoxDecoration(color: Colors.orange),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("My Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.download),
            title: Text("My Library"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DownloadsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text("Request a Book"),
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'agileelibrary@gmail.com',
                query: 'subject=Request a Book',
              );

              if (await canLaunch(emailLaunchUri.toString())) {
                await launch(emailLaunchUri.toString());
              } else {
                throw 'Could not launch ${emailLaunchUri.toString()}';
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.subscriptions),
            title: Text('My Subscription'),
            onTap: () {

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sign Out"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}




