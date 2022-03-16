import 'package:flutter/material.dart';
import '../models/restaurant.dart';

class CustomCardHome extends StatelessWidget {
  final Restaurant restaurants;

  const CustomCardHome({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.amber,
      clipBehavior: Clip.antiAlias,
      elevation: 10,
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped. ${restaurants.name}');
          },
          child: SizedBox(
            width: 300,
            height: 280,
            child: Column(
              children: <Widget>[
                Expanded(flex: 3, child: _CustomImage()),
                Expanded(flex: 2, child: _CustomDescription()),
              ],
            ),
          )),
    );
  }

  Widget _CustomImage() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(restaurants.pictureId), fit: BoxFit.cover)),
    );
  }

  Widget _CustomDescription() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurants.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      restaurants.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Text(
                  restaurants.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.star,
                  size: 26.0,
                ),
                Text(
                  restaurants.rating.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
