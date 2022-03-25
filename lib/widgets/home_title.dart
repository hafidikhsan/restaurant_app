import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _titleText(
            context,
            "Selamat Datang",
            "headline5",
          ),
          _titleText(
            context,
            "Hafid Ikhsan Arifin",
            "headline4",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: _titleText(
              context,
              "Makan apa hari ini?",
              "subtitle1",
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleText(BuildContext context, String title, String type) {
    return Text(
      title,
      style: (type == "headline5")
          ? Theme.of(context).textTheme.headline5
          : (type == "headline4")
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context).textTheme.subtitle1,
    );
  }
}
