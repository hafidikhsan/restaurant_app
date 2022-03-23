import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetCheck extends StatefulWidget {
  final WidgetBuilder onlineBuilder;
  final WidgetBuilder offlineBuilder;
  const InternetCheck({
    Key? key,
    required this.onlineBuilder,
    required this.offlineBuilder,
  }) : super(key: key);

  @override
  State<InternetCheck> createState() => _InternetCheckState();
}

class _InternetCheckState extends State<InternetCheck> {
  bool hasInternet = true;
  late StreamSubscription internetSubscription;

  @override
  void initState() {
    super.initState();

    internetSubscription = InternetConnectionChecker().onStatusChange.listen(
      (event) {
        final hasInternets = event == InternetConnectionStatus.connected;

        setState(
          () {
            hasInternet = hasInternets;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasInternet) {
      return widget.onlineBuilder(context);
    } else {
      return widget.offlineBuilder(context);
    }
  }
}
