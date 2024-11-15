import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class Downloads {
  Future<void> downloadBook(String url, String title) async {
    try {
      // Get the directory to save the file
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/$title.pdf';

      // Download the file
      await Dio().download(url, filePath);
      print('Downloaded to: $filePath');
    } catch (e) {
      print('Error downloading book: $e');
    }
  }
}

class DownloadsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Downloads')),
      body: Center(
        child: Text('Your Downloads Will Appear Here'),
      ),
    );
  }
}
