import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';

class OursPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OursPageState();
  }
}

class _OursPageState extends State<OursPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WELCOME TO OURS PAGE',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConfig.defaultBlue
        ),
      ),
    );
  }
}