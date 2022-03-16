import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static var routeName = '/detail_restaurant';
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
    );
  }
}
