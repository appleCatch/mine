import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';

class PhotoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PhotoPageState();
  }
}


class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WELCOME TO PHOTO PAGE',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConfig.defaultBlue
        ),
      ),
    );
  }
}