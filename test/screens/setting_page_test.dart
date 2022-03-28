import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/api/restaurant.dart';
import 'package:restaurant_app/providers/schedule_provider.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/screens/favorite_page.dart';
import 'package:restaurant_app/screens/home_page.dart';
import 'package:restaurant_app/screens/search_page.dart';
import 'package:restaurant_app/screens/setting_page.dart';
import 'package:restaurant_app/services/navigation.dart';
import 'package:restaurant_app/styles/styles.dart';

class TestApp extends StatelessWidget {
  final String child;

  const TestApp(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.white,
                secondary: secondaryColor,
              ),
          textTheme: myTextTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
          ),
        ),
        initialRoute: child,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          SettingPage.routeName: (context) => const SettingPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurants:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}

void main() {
  testWidgets(
    'Test Setting Page and Switch Toogle',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          SettingPage.routeName,
        ),
      );

      expect(find.text("Jadwalkan Restoran Terlaris"), findsOneWidget);
      expect(
        find.byKey(
          const Key("toogleSwitch"),
        ),
        findsOneWidget,
      );

      final Finder switchFinder = find.byKey(
        const Key('toogleSwitch'),
      );
      final switchWdt = tester.widget<Switch>(
        switchFinder,
      );

      final firstValueSwitch = switchWdt.value;

      await tester.tap(
        find.byKey(
          const Key("toogleSwitch"),
        ),
      );
      await tester.pump();

      final Finder switchFinder1 = find.byKey(
        const Key('toogleSwitch'),
      );
      final switchWdt1 = tester.widget<Switch>(
        switchFinder1,
      );

      expect(
        switchWdt1.value,
        !firstValueSwitch,
      );
    },
  );
}
