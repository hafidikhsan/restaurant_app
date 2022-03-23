import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/app_bar.dart';

class ErrorPage extends StatelessWidget {
  final String massage;
  final String title;
  final IconData image;
  const ErrorPage({
    Key? key,
    required this.massage,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
          titlePage: title,
          floatingValue: true,
          centerTitleValue: false,
          pinnedValue: false,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: screenSize.height * 0.8,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    image,
                    size: 100.0,
                    color: const Color.fromARGB(255, 42, 66, 131),
                  ),
                  Text(
                    massage,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
