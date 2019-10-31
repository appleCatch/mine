import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';

class ConfessionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfessionPageState();
  }
}


class _ConfessionPageState extends State<ConfessionPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('陪伴是最长情的告白',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConfig.defaultBlue
        ),
      ),
    );
  }
}