import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class DetailPage extends StatelessWidget {
  static var routeName = '/detail_restaurant';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.0)),
              child: Image.network(restaurant.pictureId)),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    restaurant.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 26.0,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.location_city,
                            size: 26.0,
                          ),
                          Text(
                            restaurant.city,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
