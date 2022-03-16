import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';

class HomePage extends StatefulWidget {
  static var routeName = '/restaurant_list';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: loadProduct(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                final restaurantsData = data![index];
                return CustomCardHome(
                  restaurants: restaurantsData,
                );
              });
        },
      ),
    );
  }
}
