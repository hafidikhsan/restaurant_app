import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String titlePage;
  final bool floatingValue;
  final bool centerTitleValue;
  final bool pinnedValue;

  const CustomAppBar(
      {Key? key,
      required this.titlePage,
      required this.floatingValue,
      required this.centerTitleValue,
      required this.pinnedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: centerTitleValue,
      floating: floatingValue,
      pinned: pinnedValue,
      title: Text(titlePage),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 42, 66, 131),
                Color.fromARGB(255, 30, 47, 92),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
