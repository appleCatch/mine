import 'package:flutter/material.dart';
import 'package:mine/config/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}


class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('WELCOME TO SEARCH PAGE',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConfig.defaultBlue
        ),
      ),
    );
  }
}