import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/models/restaurant.dart';

class CustomCardHome extends StatelessWidget {
  final Restaurant restaurants;

  const CustomCardHome({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                  arguments: restaurants);
            },
            child: SizedBox(
              width: 300.0,
              height: 280.0,
              child: Column(
                children: <Widget>[
                  Expanded(flex: 8, child: _customImage(context)),
                  Expanded(flex: 7, child: _customDescription(context)),
                ],
              ),
            )),
      ),
    );
  }

  Widget _customImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(restaurants.pictureId), fit: BoxFit.cover)),
    );
  }

  Widget _customDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
                    Text(restaurants.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6),
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          size: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            restaurants.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(restaurants.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Icon(
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
