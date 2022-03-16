import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';

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
        title: Text('News App'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: loadProduct(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                final restaurantsData = data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.amber,
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped. ${restaurantsData.name}');
                      },
                      child: SizedBox(
                        width: 300,
                        height: 280,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              restaurantsData.pictureId),
                                          fit: BoxFit.cover)),
                                )),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  restaurantsData.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  restaurantsData.city,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              restaurantsData.description,
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
                                              restaurantsData.rating.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )),
                );
              });
        },
      ),
    );
  }
}
