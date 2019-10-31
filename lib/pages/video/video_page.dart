import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WELCOME TO VIDEO PAGE',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConfig.defaultBlue
        ),
      ),
    );
  }
}