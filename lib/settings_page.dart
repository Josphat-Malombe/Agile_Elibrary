import 'package:agil_elibrary/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),

            SwitchListTile(
              title: Text('Dark Mode'),
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (bool value) {
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              },
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage())
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.subscriptions),
              title: Text('My Subscription'),
              onTap: () {

              },
            ),
            Divider(),
            Divider(),

            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              subtitle: Text('Version 1.0.0'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text("Contact Support"),
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'agileelibrary@gmail.com',
                  query: 'subject=Contact Support',
                );

                if (await canLaunch(emailLaunchUri.toString())) {
                  await launch(emailLaunchUri.toString());
                } else {
                  throw 'Could not launch ${emailLaunchUri.toString()}';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
