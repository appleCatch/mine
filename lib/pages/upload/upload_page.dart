import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadPageState();
  }
}

class _UploadPageState extends State<UploadPage> {
  List<File> imageList = List<File>();

  Future<File> _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageList.add(image);
    });
  }


  dynamic _getBody() {
    if(_showLoadingDialog()) {
      return _getProcessingDialog();
    } else {
      return _getListView();
    }
  }





  @override
  Widget build(BuildContext context) {
    return null;
  }

  bool _showLoadingDialog() {
    return imageList.length == 0;
  }

  _getProcessingDialog() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _getListView() {
    return ListView.builder(
      itemCount: imageList.length,
      itemBuilder: (context, position) {
        return Image.file(imageList[position], height: 300,);
      }
    );
  }
}