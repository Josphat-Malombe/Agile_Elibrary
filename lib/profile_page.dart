import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'downloads.dart';
import 'settings_page.dart';
import 'signin.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? _user;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchUserImageUrl();
  }

  Future<void> _fetchUserImageUrl() async {
    if (_user != null) {
      try {
        DatabaseEvent event = await _database.child('users/${_user!.uid}').once();
        final data = event.snapshot.value as Map<dynamic, dynamic>?;

        setState(() {
          _imageUrl = data?['imageUrl'] as String?;
        });
      } catch (e) {
        print('Error fetching image URL: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      String? imageUrl = await _uploadImageToFirebase(selectedImage);
      if (imageUrl != null) {
        setState(() {
          _imageUrl = imageUrl;
        });
        await _saveUserImageUrl(imageUrl);
      } else {
        print('Failed to upload image.');
      }
    }
  }

  Future<String?> _uploadImageToFirebase(File image) async {
    try {
      String fileName = 'user_images/${_user!.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      TaskSnapshot snapshot = await _storage.ref(fileName).putFile(image);

      // Get the download URL after the upload
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveUserImageUrl(String imageUrl) async {
    if (_user != null) {
      try {
        await _database.child('users/${_user!.uid}').update({
          'imageUrl': imageUrl,
        });
        print('Saved image URL: $imageUrl');
      } catch (e) {
        print('Error saving image URL: $e');
      }
    }
  }

  void _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageUrl != null
                    ? NetworkImage(_imageUrl!)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
                child: _imageUrl == null
                    ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                    : null,
              ),
            ),
            SizedBox(height: 16),

            Text(
              _user?.displayName ?? 'Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(_user?.email ?? 'Email not available'),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.download),
              title: Text('My Downloads'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DownloadsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('App Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            Divider(),
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
      ),
    );
  }
}

