import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';

class ShortButton extends StatelessWidget {
  const ShortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: (state.short)
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(255, 42, 66, 131),
                        )
                      : null,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: () {
                  state.short = !state.short;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.filter_list,
                      color: state.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text(
                        'Urutkan Rating',
                        style: TextStyle(
                          color: state.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
