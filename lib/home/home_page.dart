import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('首页'),
    );
  }
}
